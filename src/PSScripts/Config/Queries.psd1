@{
"init_db" = "IF DB_ID('BikeStores') IS NOT NULL
              BEGIN
                ALTER DATABASE [BikeStores] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
                DROP DATABASE [BikeStores];
              END
            CREATE DATABASE [BikeStores];";
}