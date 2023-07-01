# Use uma Imagem Official do Python
FROM python:3

# Adicionando um usuário de sistema
RUN adduser --system --home /home/myapp/ myapp
USER myapp

# Definindo o diretório onde a aplicação será armazenada
WORKDIR /home/myapp

#Definindo o local onde o binário do gunicorn é instalado
ENV PATH="/home/myapp/.local/bin:${PATH}"

#Variaveis para inicializacao da app
ENV CLOUD_SQL_USERNAME="dbadmin"
ENV CLOUD_SQL_PASSWORD="Hackaton@2023"
ENV CLOUD_SQL_DATABASE_NAME="playlist"
ENV DB_LOCAL_HOST="35.232.253.183"
ENV CLOUD_SQL_CONNECTION_NAME="grupo-01-390620:us-central1:hacka-instance-mysql"

# Copiar o arquivo da aplicação sem atribuir permissão de escrita
COPY . /home/myapp/

# Copiar os arquivos da pasta local para dentro do container
COPY requirements.txt /home/myapp/

# Instalar as dependências de Python de acordo com o que foi desenvolvido na aplicação e que está declarado no arquivo requirements.txt.
RUN pip install --user --trusted-host pypi.python.org -r requirements.txt

# Garante que será iniciado a aplicação.
CMD ["gunicorn", "app:app"]