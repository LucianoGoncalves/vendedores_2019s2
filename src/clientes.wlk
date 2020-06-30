class Cliente {

	method puedeSerAtendidoPor(unVendededor)

}

class ClienteInseguro inherits Cliente {

	override method puedeSerAtendidoPor(unVendededor) {
		return unVendededor.esVersatil() and unVendededor.esFirme()
	}

}

class ClienteDetallista inherits Cliente {

	override method puedeSerAtendidoPor(unVendededor) {
		return unVendededor.cantidadDeCertificacionesQueSonProductos() >= 3
	}

}

class ClienteHumanista inherits Cliente {

	override method puedeSerAtendidoPor(unVendededor) {
		return unVendededor.esPersonaFisica()
	}

}

