import ciudades.*
import provincias.*
import certificados.*
import centrosDeDistribucion.*

class Vendedor {

	var property certificaciones = []

	method agregarCertificacion(unaCertificacion) {
		certificaciones.add(unaCertificacion)
	}

	method sacarCertificacion(unaCertificacion) {
		certificaciones.remove(unaCertificacion)
	}

	method puedeTrabajarEn(unaCiudad)

	method esVersatil() {
		return certificaciones.size() >= 3 and self.cantidadDeCertificacionesQueSonProductos() >= 1 and self.cantidadDeCertificacionesQueNoSonProductos() >= 1
	}

	method cantidadDeCertificacionesQueSonProductos() {
		return certificaciones.count({ certificacion => certificacion.esProducto() })
	}

	method cantidadDeCertificacionesQueNoSonProductos() {
		return certificaciones.count({ certificacion => not certificacion.esProducto() })
	}

	method esFirme() {
		return certificaciones.sum({ certificacion => certificacion.puntos() }) >= 30
	}

	method esInfluyente()

	method puntos() {
		certificaciones.sum({ certificado => certificado.puntos()})
	}

	method tieneAfinidadCon(unCentroDeDistribucion) {
		return self.puedeTrabajarEn(unCentroDeDistribucion.ciudad())
	}

	method esCandidatoPara(unCentroDeDistribucion) {
		return self.esVersatil() and self.tieneAfinidadCon(unCentroDeDistribucion)
	}

	method esPersonaFisica() {
		return true
	}

}

class VendedorFijo inherits Vendedor {

	var property ciudadEnDondeVive

	override method puedeTrabajarEn(unaCiudad) {
		return unaCiudad == ciudadEnDondeVive
	}

	override method esInfluyente() {
		return false
	}

}

class Viajante inherits Vendedor {

//revisar provincia en Vendedores
	var property provinciaEnLaQueEstaHabilitado = []

	method agregarProvincia(unaProvincia) {
		provinciaEnLaQueEstaHabilitado.add(unaProvincia)
	}

	method sacarProvincia(unaProvincia) {
		provinciaEnLaQueEstaHabilitado.remove(unaProvincia)
	}

	override method puedeTrabajarEn(unaCiudad) {
		return provinciaEnLaQueEstaHabilitado.map({ provincia => provincia.ciudad() }).any({ provincia => provincia == unaCiudad })
	}

	override method esInfluyente() {
		return provinciaEnLaQueEstaHabilitado.sum({ unaProvincia => unaProvincia.poblacion() }) >= 10000000
	}

}

class ComercioCorresponsal inherits Vendedor {

	var property sucursalesEnCiudades = #{}

	method agregarCiudad(unaCiudad) {
		sucursalesEnCiudades.add(unaCiudad)
	}

	method sacarCiudad(unaCiudad) {
		sucursalesEnCiudades.remove(unaCiudad)
	}

	override method puedeTrabajarEn(unaCiudad) {
		return sucursalesEnCiudades.contains(unaCiudad)
	}

	override method esInfluyente() {
		return self.cantidadDeSucursalesEnCiudades() >= 5 or self.cantidadDeSucursalesEnProvincias() >= 3
	}

	method cantidadDeSucursalesEnCiudades() {
		return sucursalesEnCiudades.size()
	}

	method cantidadDeSucursalesEnProvincias() {
		return sucursalesEnCiudades.map({ ciudad => ciudad.provincia() }).size()
	}

	override method tieneAfinidadCon(unCentroDeDistribucion) {
		return super(unCentroDeDistribucion) and self.cantidadDeSucursalesEnCiudades() >= 1 and not unCentroDeDistribucion.puedeCubrir(sucursalesEnCiudades.intersection(unCentroDeDistribucion.ciudadActual()))
	}

	override method esPersonaFisica() {
		return false
	}

}

