import pyodbc

#Entidades -tablas de mysql

class Clientes:
    id_cliente: int = 0
    nombre: str = None
    telefono: str = None
    correo: str = None
    direccion: str = None

print('ok tabla clientes')

class Propiedades:
    id_propiedad: int = 0
    direccion: str = None
    tipo: str = None
    precio_mensual: float = 0
    disponible: int = 1

print('ok tabla Propiedades')

class Alquileres:
    id_alquiler: int = 0
    id_cliente: int = 0
    id_propiedad: int = 0
    fecha_inicio: str = None
    fecha_fin: str = None

print('ok tabla alquileres')

class Conexion:
    cadena_conexion = (
        "Driver={MySQL ODBC 9.4 Unicode Driver};"
        "Server=localhost;"
        "Database=db_alquiler;"
        "Port=3306;"
        "User=user_python;"
        "Password=123456;"
    )

    #INSERTAR
    def InsertarAlquileres(self):
        try:
            conexion = pyodbc.connect(self.cadena_conexion)
            cursor = conexion.cursor()
            print("Conexión ok")

            datos = [(2, 1, "2025-09-01", "2025-12-01"), #desde el 2, por que borré el primer cliente
                (3, 2, "2025-08-15", "2026-02-15"),(4, 3, "2025-09-10", None)]

            for a in datos:
                consulta = f"""
                    insert into alquileres (id_cliente, id_propiedad, fecha_inicio, fecha_fin)
                    values ({a[0]}, {a[1]}, '{a[2]}', {'NULL' if a[3] is None else f"'{a[3]}'"}); """ #si tercera fecha es None, poner Null
                cursor.execute(consulta)

            conexion.commit()
            print("Alquileres ingresados correctamente en la bd")

            cursor.close()
            conexion.close()
        except Exception as e:
            print("Error al insertar:", e)


    # Consulta
    def ConsultarAlquileres(self):
        conexion = pyodbc.connect(self.cadena_conexion)
        cursor = conexion.cursor()
        cursor.execute("SELECT * FROM alquileres;")

        filas = cursor.fetchall() #todas filas de la consulta
        print("Alquileres en la bd: ")
        for fila in filas:
            print(f"Id alquiler: {fila[0]}, Cliente: {fila[1]}, Propiedad: {fila[2]}, "
                  f"Inicio: {fila[3]}, Fin: {fila[4]}")

        cursor.close()
        conexion.close()


    # Actualizar: 
    def ActualizarFechaFin(self, id_alquiler, nueva_fecha):
        try:
            conexion = pyodbc.connect(self.cadena_conexion)
            cursor = conexion.cursor()

            consultaq= f"""
                update alquileres
                set fecha_fin = '{nueva_fecha}'
                where id_alquiler = {id_alquiler};
            """
            cursor.execute(consultaq)
            conexion.commit()
            print(f"Alquiler con Id:  {id_alquiler} actualizado con nueva fecha fin {nueva_fecha}")

            cursor.close()
            conexion.close()
        except Exception as e:
            print("Error al actualizar:", e)


    # Eliminar
    def EliminarAlquiler(self, id_alquiler):
        try:
            conexion = pyodbc.connect(self.cadena_conexion)
            cursor = conexion.cursor()

            consulta = f"delete from alquileres where id_alquiler = {id_alquiler};"
            cursor.execute(consulta)
            conexion.commit()
            print(f"Alquiler con Id  {id_alquiler} eliminado correctamente")

            cursor.close()
            conexion.close()
        except Exception as e:
            print("Error al eliminar:", e)


db = Conexion()

print("Conexión a base de datos")
print("------------------------------")

print("Insertando alquileres")
db.InsertarAlquileres()

print("------------------------------")
print("Consultando alquileres")
db.ConsultarAlquileres()

print("------------------------------")
print("Actualizando fecha fin de un alquiler")
db.ActualizarFechaFin(2, "2026-01-01")

print("------------------------------")
print("Eliminando alquiler con id 2")
db.EliminarAlquiler(2)

print("------------------------------")
print("Consultando nuevamente")
db.ConsultarAlquileres()
