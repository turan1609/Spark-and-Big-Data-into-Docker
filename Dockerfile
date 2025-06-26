# --- AŞAMA 1: BUILDER (İnşaat Sahası) ---
# Bu aşama, kütüphaneleri derlemek için gerekli tüm araçları içerir
# ama son imajda yer kaplamaz.
FROM python:3.9-alpine AS builder

# Önce sadece derleme için gerekli olan sistem paketlerini kuruyoruz.
# build-base: gcc, make gibi derleme araçlarını içerir.
# linux-headers: psutil gibi kütüphanelerin derlenmesi için gereklidir.
RUN apk add --no-cache build-base linux-headers

# Derleme için çalışma dizinini ayarlıyoruz.
WORKDIR /app

# Sadece bağımlılık dosyasını kopyalıyoruz.
COPY requirements.txt .

# Tüm Python bağımlılıklarını bu "kirli" ortamda kuruyoruz.
# Bu aşamada kurulan paketler daha sonra temiz ortama kopyalanacak.
RUN pip wheel --no-cache-dir --wheel-dir=/wheels -r requirements.txt


# --- AŞAMA 2: FINAL (Bitmiş Ürün) ---
# Şimdi her şeye temiz ve minimal bir temel imajla yeniden başlıyoruz.
FROM python:3.9-alpine

# Sadece programın ÇALIŞMASI için gereken sistem paketlerini kuruyoruz.
# DİKKAT: 'build-base' ve 'linux-headers' gibi derleme araçları burada YOK!
# Bu sayede yüzlerce MB'lık yerden tasarruf ediyoruz.
RUN apk add --no-cache openjdk11-jre bash

# Gerekli ortam değişkenlerini ayarlıyoruz. Bu, PySpark'ın hatasız
# çalışması için kritiktir.
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk
ENV SPARK_HOME=/usr/local/lib/python3.9/site-packages/pyspark
ENV PATH=$PATH:$JAVA_HOME/bin:$SPARK_HOME/bin

# Çalışma dizinini ayarlıyoruz.
WORKDIR /app

# Bir önceki aşamada (builder) derlediğimiz Python paketlerini kopyalıyoruz.
COPY --from=builder /wheels /wheels

# Kopyaladığımız "wheel" dosyalarından kurulumu yapıyoruz. Bu, yeniden derleme
# yapmadan çok daha hızlı bir şekilde kurulumu tamamlar.
RUN pip install --no-cache-dir /wheels/*

# Projemizin geri kalan tüm dosyalarını (.ipynb, .csv) kopyalıyoruz.
COPY . .

# Konteyner başlatıldığında çalıştırılacak nihai komut.
CMD ["python", "-m", "notebook", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--no-browser", "--NotebookApp.token="]
