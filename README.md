# Spark-and-Big-Data-into-Docker

## PySpark Book Recommendation System with Docker

This project demonstrates the development of a book recommendation system using PySpark to process large datasets. The entire development environment is containerized with Docker, showcasing how a complex data science stack can be easily set up and run on any machine.

## Project Overview

The primary objectives of this project are:
  * To process and analyze large book rating datasets (Books.csv, Ratings.csv, Users.csv) using PySpark DataFrames.
  * To apply data preprocessing and cleaning techniques.
  * To train a collaborative filtering model using the ALS (Alternating Least Squares) algorithm from PySpark's ML library.
  * To evaluate the model's performance and generate book recommendations for users.
  * To "Dockerize" the entire environment, making it portable and easy to run with a single command.
  
## Technology Stack & Optimization
 
The Docker environment for this project was designed with efficiency and minimalism in mind:
 
  * **Base Image:** The environment is built upon python:3.9-alpine, a minimal base image that significantly reduces the overall size.
  * **Optimization Technique:** A **Multi-Stage Build** is implemented in the Dockerfile. This technique ensures that build-time dependencies(like build-base) are not included in the final image,       resulting in a much smaller and more secure production image.
  * **Dependency Management:** All system-level dependencies (Java, bash) and Python libraries (PySpark, Pandas, etc.) are managed within the Dockerfile, ensuring a consistent and reproducible environment.
   
This optimized approach reduces the image size from a potential 5+ GB (using a standard pre-built data science image) to approximately ~1.6 GB, making it highly efficient for distribution and storage.

## Project File Structure   


  * BigDataFinal(1).ipynb     # The main Jupyter Notebook for the project
  * Books.csv                 # Dataset containing book information
  * Dockerfile                # Defines the steps to build the custom Docker image
  * Ratings.csv               # Dataset containing book rating data
  * README.md                 # This documentation file
  * Users.csv                 # Dataset containing user information
  * docker-compose.yml        # A file to easily manage and run the Docker container
  * requirements.txt          # A list of required Python libraries

## Setup and Execution

To run this project, you only need Docker Desktop (for Windows/macOS) or Docker Engine + Docker Compose (for Linux) installed on your machine. You do not need to install Python, Java, or Spark locally.

### Step 1: Clone the Repository

First, clone this repository to your local machine or download it as a zip file.
```
git clone https://github.com/turan1609/Spark-and-Big-Data-into-Docker.git
cd Spark-and-Big-Data-into-Docker
```
### Step 2: Start the Docker Container

Navigate to the project's root directory in your terminal and run the following single command:

`docker compose up --build`

What does this command do?
  * The --build flag instructs Docker Compose to build the custom image using the Dockerfile on the first run.
  * It installs all necessary system dependencies (like Java and bash) and Python libraries (PySpark, Pandas, etc.).
  * Once the image is built, it starts a container from that image.
  * It automatically starts the Jupyter Notebook server inside the container.

Note: The initial build process may take several minutes, depending on your internet speed, as it needs to download dependencies. Subsequent runs using docker compose up will be much faster, typically taking only a few seconds.

### Step 3: Access Jupyter Notebook

Once you see the Jupyter Server is running at... message in your terminal, open your web browser and navigate to the following address:

(http://localhost:8888)

You will see the Jupyter interface listing the project files. Click on BigDataFinal(1).ipynb to open the notebook, run the cells, and see the results.

### Step 4: Monitor Spark Jobs (Optional)

To monitor the status, stages, and performance of your Spark jobs, you can access the Spark UI at the following address:

(http://localhost:4040)

### Stopping the Project

When you are finished, return to the terminal where the docker compose up command is running and press Ctrl + C. This will gracefully shut down the Jupyter server and the container.

To completely remove the container, network, and other resources created by this project, run the following command:

`docker compose down`

This documentation outlines both the technical infrastructure and the practical usage of the project. Happy coding.
