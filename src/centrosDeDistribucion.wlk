import vendedores.*
import certificados.*

class CentroDeDistribucion {

	var property ciudadActual = #{}
	var property vendedoresConLosQueTrabajan = []

	method agregarVendedor(unVendedor) {
		if (self.estaRegistrado(unVendedor)) {
			self.error("el vendedor ya esta registrado")
		}
		vendedoresConLosQueTrabajan.add(unVendedor)
	}

	method sacarVendedor(unVendedor) {
		vendedoresConLosQueTrabajan.remove(unVendedor)
	}

	method estaRegistrado(unVendedor) {
		return vendedoresConLosQueTrabajan.contains(unVendedor)
	}

	method vendedorEstrella() {
		return vendedoresConLosQueTrabajan.max({ vendedor => vendedor.puntos() })
	}

	method puedeCubrir(unaCiudad) {
		return vendedoresConLosQueTrabajan.any({ vendedor => vendedor.puedeTrabajarEn(unaCiudad) })
	}

	method vendedoresGenericos() {
		return vendedoresConLosQueTrabajan.filter({ vendedor => vendedor.cantidadDeCertificacionesQueNoSonProductos() >= 1 })
	}

	method esRobusto() {
		return vendedoresConLosQueTrabajan.count({ vendedor => vendedor.esFirme() }) >= 3
	}

	method repartirCertificacion(unaCertificacion) {
		vendedoresConLosQueTrabajan.forEach({ vendedor => vendedor.agregarCertificacion(unaCertificacion)})
	}

}

