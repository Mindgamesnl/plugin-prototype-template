asdf local java openjdk-18.0.2.1
export JAVA_HOME=`/usr/libexec/java_home -v 17`
mkdir -p test-server-spigot/plugins/
echo "Building new plugin jar without unit tests.."
mvn -T 4.5C install -Dmaven.test.skip=true

rm test-server-spigot/plugins/prototype-plugin*

cp target/prototype-plugin.jar test-server-spigot/plugins/
cp dev-resources/bukkit.yml test-server-spigot/
cp dev-resources/server.properties test-server-spigot/
cp dev-resources/ops.json test-server-spigot/

cd test-server-spigot
echo "Cleaning server..."
if [ ! -f ./spigot-1.19.4.jar ]; then
    wget https://download.getbukkit.org/spigot/spigot-1.19.4.jar
    echo "eula=true" > eula.txt
    chmod +x spigot-1.19.4.jar
fi

echo "Starting server.."
rm world/session.lock
rm world_the_end/session.lock
rm world_nether/session.lock
java -Xms3G -Xmx3G -jar spigot-1.19.4.jar nogui