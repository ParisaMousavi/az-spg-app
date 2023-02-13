az account show
resourcegroupname="dummyazspgap1"
location="westeurope1"

# Provision an instance of Azure Spring Apps
echo "Provision an instance of Azure Spring Apps"
echo "--------------------------------------------"
az group create \
    --resource-group $resourcegroupname \
    --location $location

az spring create \
    --resource-group $resourcegroupname \
    --name $resourcegroupname \
    --sku Basic 

# Create an app in your Azure Spring Apps instance
echo "Create an app in your Azure Spring Apps instance"
echo "--------------------------------------------"
az spring app create \
    --resource-group $resourcegroupname \
    --service $resourcegroupname \
    --name hellospring \
    --assign-endpoint true \
    --runtime-version Java_11 

# Clone and build the Spring Boot sample project
echo "Clone and build the Spring Boot sample project"
echo "--------------------------------------------"
git clone https://github.com/spring-guides/gs-spring-boot.git
cd gs-spring-boot/complete
mvn clean package -DskipTests

# Deploy the local app to Azure Spring Apps
echo "Deploy the local app to Azure Spring Apps"
echo "--------------------------------------------"
az spring app deploy \
    --resource-group $resourcegroupname \
    --service $resourcegroupname \
    --name hellospring \
    --artifact-path target/spring-boot-complete-0.0.1-SNAPSHOT.jar

# Verify sample is working
echo "Verify sample is working"
echo "--------------------------------------------"
az spring app show -n gateway -s $resourcegroupname -g $resourcegroupname | jq -r .properties.url

curl {url}/greeting-client/hello
