/***************************************************************************
                 flfactpresta.qs  -  description
                             -------------------
    begin                : lun abr 26 2004
    copyright            : (C) 2004 by InfoSiAL S.L.
    email                : mail@infosial.com
 ***************************************************************************/
/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

/** @file */

/** @class_declaration interna */
////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
class interna {
	var ctx:Object;
	function interna( context ) { this.ctx = context; }
	function init() { this.ctx.interna_init(); }
	function afterCommit_stocks(curStock:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_stocks(curStock);
	}
	function beforeCommit_stocks(curStock:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_stocks(curStock);
	}
	function afterCommit_lineastransstock(curLTS:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_lineastransstock(curLTS);
	}
	function afterCommit_lineasregstocks(curLRS:FLSqlCursor):Boolean {
                return this.ctx.interna_afterCommit_lineasregstocks(curLRS);
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
  function oficial( context ) { interna( context ); }

}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration sincrocat */
/////////////////////////////////////////////////////////////////
//// SINCRO CAT�LOGO ////////////////////////////////////////////
class sincrocat extends oficial /** %from: oficial */
{
  var conOrigen_, conDestino_;
  var password_;
  var aDatos_;
  var curDestino_, curDestinoSin_, mgr_;
  var tSTRING_ = 3, tDATE_ = -1; /// No s� cu�l es el de date

  function sincrocat(context)
  {
    oficial(context);
  }
  function sincronizar(silent, esquema)
  {
    return this.ctx.sincrocat_sincronizar(silent, esquema);
  }
  function sincronizarTrans(silent, esquema)
  {
    return this.ctx.sincrocat_sincronizarTrans(silent, esquema);
  }
  function conectarSinc(conName)
  {
    return this.ctx.sincrocat_conectarSinc(conName);
  }
  function pedirPassword()
  {
    return this.ctx.sincrocat_pedirPassword();
  }
  function sincronizarTabla(tabla, aResultados, silent)
  {
    return this.ctx.sincrocat_sincronizarTabla(tabla, aResultados, silent);
  }
  function copiarRegistroDestino(curOrigen, oTabla, aResultados)
  {
    return this.ctx.sincrocat_copiarRegistroDestino(curOrigen, oTabla, aResultados);
  }
  function crearRegistroDestino(curOrigen, oTabla)
  {
    return this.ctx.sincrocat_crearRegistroDestino(curOrigen, oTabla);
  }
  function borrarRegistroDestino(curOrigen, oTabla)
  {
    return this.ctx.sincrocat_borrarRegistroDestino(curOrigen, oTabla);
  }
  function regSincronizado(curOrigen, oTabla)
  {
    return this.ctx.sincrocat_regSincronizado(curOrigen, oTabla);
  }
  function dameCamposTabla(tabla)
  {
    return this.ctx.sincrocat_dameCamposTabla(tabla);
  }
  function calculaCampoSincro(curDestino, oTabla, campo)
  {
    return this.ctx.sincrocat_calculaCampoSincro(curDestino, oTabla, campo);
  }
  function datosRegistro(curO, curD, campo)
  {
    return this.ctx.sincrocat_datosRegistro(curO, curD, campo);
  }
  function sincronizarCampo(curO, curD, campo)
  {
    return this.ctx.sincrocat_sincronizarCampo(curO, curD, campo);
  }
  function establecerConexionesSinc(conOrigen: String, conDestino: String): Boolean {
    return this.ctx.sincrocat_establecerConexionesSinc(conOrigen, conDestino);
  }
  function dameResultadosSincro(): String {
    return this.ctx.sincrocat_dameResultadosSincro();
  }
  function dameElementoSincro(t)
  {
    return this.ctx.sincrocat_dameElementoSincro(t);
  }
  function dameOrdenTablas(esquema)
  {
    return this.ctx.sincrocat_dameOrdenTablas(esquema);
  }
  function dameDatosTabla(t, esquema)
  {
    return this.ctx.sincrocat_dameDatosTabla(t, esquema);
  }
  function dameObjetoTabla(t, esquema)
  {
    return this.ctx.sincrocat_dameObjetoTabla(t, esquema);
  }
  function dameOrderByTabla(oTabla)
  {
    return this.ctx.sincrocat_dameOrderByTabla(oTabla);
  }
  function dameClaveTabla(curTabla, oTabla)
  {
    return this.ctx.sincrocat_dameClaveTabla(curTabla, oTabla);
  }
  function afterSincronizarTabla(oTabla, aResultados, silent)
  {
    return this.ctx.sincrocat_afterSincronizarTabla(oTabla, aResultados, silent);
  }
  function beforeCommit_stocks(curStock)
  {
    return this.ctx.sincrocat_beforeCommit_stocks(curStock);
  }
  function beforeCommit_lineasregstocks(curL)
  {
    return this.ctx.sincrocat_beforeCommit_lineasregstocks(curL);
  }
  function controlIdSincroStock(curStock)
  {
    return this.ctx.sincrocat_controlIdSincroStock(curStock);
  }
  function controlIdSincroRegStock(curL)
  {
    return this.ctx.sincrocat_controlIdSincroRegStock(curL);
  }
  function controlUltMovStock(curStock)
  {
    return this.ctx.sincrocat_controlUltMovStock(curStock);
  }
}
//// SINCRO CAT�LOGO ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends sincrocat {
	function head( context ) { sincrocat ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
	function ifaceCtx( context ) { head( context ); }
	function pub_cambiarStock(codAlmacen:String, referencia:String, variacion:Number, campo:String, noAvisar:Boolean ):Boolean {
		return this.cambiarStock(codAlmacen, referencia, variacion,campo, noAvisar);
	}
	function pub_crearStock(codAlmacen:String, referencia:String):Number {
		return this.crearStock(codAlmacen, referencia);
	}
	function pub_cambiarCosteMedio(referencia:String):Boolean {
		return this.cambiarCosteMedio(referencia);
	}
	function pub_controlStockPedidosCli(curLP:FLSqlCursor):Boolean {
		return this.controlStockPedidosCli(curLP);
	}
	function pub_controlStockPedidosProv(curLP:FLSqlCursor):Boolean {
		return this.controlStockPedidosProv(curLP);
	}
	function pub_controlStockAlbaranesCli(curLA:FLSqlCursor):Boolean {
		return this.controlStockAlbaranesCli(curLA);
	}
	function pub_controlStockAlbaranesProv(curLA:FLSqlCursor):Boolean {
		return this.controlStockAlbaranesProv(curLA);
	}
	function pub_controlStockFacturasCli(curLF:FLSqlCursor):Boolean {
		return this.controlStockFacturasCli(curLF);
	}
	function pub_controlStockComandasCli(curLV:FLSqlCursor):Boolean {
		return this.controlStockComandasCli(curLV);
	}
	function pub_controlStockFacturasProv(curLF:FLSqlCursor):Boolean {
		return this.controlStockFacturasProv(curLF);
	}
	function pub_controlStockValesTPV(curLinea:FLSqlCursor):Boolean {
		return this.controlStockValesTPV(curLinea);
	}
	function pub_valorDefectoAlmacen(fN:String):String {
		return this.valorDefectoAlmacen(fN);
	}
}

const iface = new pubSincrocat( this );
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubSincrocat */
/////////////////////////////////////////////////////////////////
//// PUB SINCRO CATALOGO ////////////////////////////////////////
class pubSincrocat extends ifaceCtx /** %from: ifaceCtx */
{
  function pubSincrocat(context)
  {
    ifaceCtx(context);
  }
  function pub_establecerConexionesSinc(conOrigen, conDestino)
  {
    return this.establecerConexionesSinc(conOrigen, conDestino);
  }
  function pub_sincronizarTrans(silent, esquema)
  {
    return this.sincronizarTrans(silent, esquema);
  }
  function pub_dameResultadosSincro(): String {
    return this.dameResultadosSincro();
  }
  function pub_conectarSinc(conName)
  {
    return this.conectarSinc(conName);
  }
}
//// PUB SINCRO CATALOGO ////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition interna */
////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
/** \D Si no hay ning�n almac�n en la tabla almacenes se inserta uno por defecto
\end */
function interna_init()
{
	var cursor:FLSqlCursor = new FLSqlCursor("almacenes");
	cursor.select();
	if (!cursor.first()) {
		var util:FLUtil = new FLUtil();
		MessageBox.information(util.translate("scripts",
			"Se insertar� un almac�n por defecto para empezar a trabajar."),
			MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		with (cursor) {
			setModeAccess(Insert);
			refreshBuffer();
			setValueBuffer("codalmacen","ALG");
			setValueBuffer("nombre", util.translate("scripts","ALMACEN GENERAL"));
			commitBuffer();
		}
		cursor = new FLSqlCursor("empresa");
		cursor.select();
		if (cursor.first()) {
			with (cursor) {
				setModeAccess(cursor.Edit);
				refreshBuffer();
				if (!valueBuffer("codalmacen")) {
					setValueBuffer("codalmacen","ALG");
					commitBuffer();
				}
			}
		}
	}

	///////////// BORRAR 25/09/08 ///////////////////////////////
	// Es para inicializar los dos campos nuevos Se compra y Se vende a true.
	var util:FLUtil;
	if(!util.sqlSelect("articulos","referencia","secompra OR sevende")) {
		MessageBox.information(util.translate("scripts", "A continuaci�n se van a actualizar los nuevos campos de los art�culos\nEsto puede llevar algunos segundos"),
			MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		util.sqlUpdate("articulos","secompra",true,"1 = 1");
		util.sqlUpdate("articulos","sevende",true,"1 = 1");
		MessageBox.information(util.translate("scripts", "Proceso finalizado"),
			MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
	}
	///////////// BORRAR 25/09/08 ///////////////////////////////
}

/** \D
Actualiza el stock f�sico total en la tabla de art�culos
\end */
function interna_afterCommit_stocks(curStock:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	var referencia:String = curStock.valueBuffer("referencia");
	var stockFisico:Number = util.sqlSelect("stocks", "SUM(cantidad)", "referencia = '" + referencia + "'");
	switch (curStock.modeAccess()) {
		case curStock.Edit:
			var refAnterior:String = curStock.valueBufferCopy("referencia");
			if (referencia != refAnterior) {
				if (!util.sqlUpdate("articulos", "stockfis", stockFisico, "referencia = '" + refAnterior + "'"))
					return false;
			}
		case curStock.Insert:
// 			if((curStock.valueBufferCopy("cantidad") != curStock.valueBuffer("cantidad")) || (curStock.valueBufferCopy("reservada") != curStock.valueBuffer("reservada"))) {
// 				curStock.setValueBuffer("disponible",parseFloat(curStock.valueBuffer("cantidad")) - parseFloat(curStock.valueBuffer("reservada")));
// 			}
		case curStock.Del:
			if (!util.sqlUpdate("articulos", "stockfis", stockFisico, "referencia = '" + referencia + "'"))
				return false;
	}
	return true;
}

/** \D
Avisa al usuario en caso de querer borrar un stock con cantidad distinta de 0
\end */
function interna_beforeCommit_stocks(curStock:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	switch (curStock.modeAccess()) {
		case curStock.Del: {
			if (parseFloat(curStock.valueBuffer("cantidad")) != 0) {
				var res:Number = MessageBox.warning(util.translate("scripts", "Va a eliminar un registro de stock con cantidad distinta de 0.\n�Est� seguro?"), MessageBox.No, MessageBox.Yes);
				if (res != MessageBox.Yes)
					return false;
			}
		}
	}
	return true;
}

function interna_afterCommit_lineastransstock(curLTS:FLSqlCursor):Boolean {
	return this.iface.controlStockLineasTrans(curLTS);
}


function interna_afterCommit_lineasregstocks(curLRS:FLSqlCursor):Boolean
{
debug("interna_afterCommit_lineasregstocks");
    if (!this.iface.controlRegStock(curLRS)) {
        return false;
    }
    return true;
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D Cambia el valor del stock en un determinado almac�n. Se comprueba si el valor de la variaci�n es negativo y mayor al stock actual, en cuyo caso se avisa al usuario de la falta de existencias

@param codAlmacen C�digo del almac�n
@param referencia Referencia del art�culo
@param variaci�n Variaci�n en el n�mero de existencias del art�culo
@param  campo: Nombre del campo a modificar. Si el campo es vac�o o es --cantidad-- se llama a la funci�n padre
@return True si la modificaci�n tuvo �xito, false en caso contrario
\end */

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition sincrocat */
/////////////////////////////////////////////////////////////////
//// SINCRO CATALOGO ////////////////////////////////////////////
function sincrocat_sincronizarTrans(silent, esquema)
{
  var _i = this.iface;
  var util: FLUtil = new FLUtil;
  _i.aDatos_ = new Array;

  if (!_i.mgr_) {
    _i.mgr_ = aqApp.db().manager();
  }

  var curTOrigen: FLSqlCursor = (_i.conOrigen_ ? new FLSqlCursor("empresa", _i.conOrigen_) : new FLSqlCursor("empresa"));
  var curTDestino: FLSqlCursor = (_i.conDestino_ ? new FLSqlCursor("empresa", _i.conDestino_) : new FLSqlCursor("empresa"));
  if (!curTOrigen.transaction(false)) {
    return false;
  }
  if (!AQUtil.execSql("BEGIN", _i.conDestino_)) {
    curTOrigen.rollback();
    return false;
  }
  try {
    if (_i.sincronizar(silent, esquema)) {
      if (!AQUtil.execSql("COMMIT", _i.conDestino_)) {
        return false;
      }
      curTOrigen.commit();
    } else {
      if (!AQUtil.execSql("ROLLBACK", _i.conDestino_)) {
        return false;
      }
      curTOrigen.rollback();
      if (silent) {
        debug("Error en la sincronizaci�n");
      } else {
        MessageBox.warning(sys.translate("Error en la sincronizaci�n"), MessageBox.Ok, MessageBox.NoButton);
      }
      return false;
    }
  } catch (e) {
    if (!AQUtil.execSql("ROLLBACK", _i.conDestino_)) {
      return false;
    }
    curTOrigen.rollback();
    if (silent) {
      debug("Error en la sincronizaci�n:" + e);
    } else {
      MessageBox.critical(sys.translate("Error en la sincronizaci�n: ") + e, MessageBox.Ok, MessageBox.NoButton);
    }
    return false;
  }
  return true;
}

function sincrocat_sincronizar(silent, esquema)
{
  var _i = this.iface;

  try {
    flfactppal.iface.pub_appendTextToLogFile(_i.logName_, "Sincronizando (inicio)");
    var aDatos: Array = [];

    var tablas = _i.dameOrdenTablas(esquema);
    if (!tablas) {
      return false;
    }
    var oT;
    for (var i = 0; i < tablas.length; i++) {
      oT = _i.dameObjetoTabla(tablas[i], esquema);
      if (!oT) {
        if (!flfactppal.iface.pub_appendTextToLogFile(_i.logName_, "Error al obtener los datos del objeto tabla " + tablas[i])) {
          sys.infoMsgBox("Error al obtener los datos del objeto tabla " + tablas[i]);
        }
        return false;
      }
      if (!_i.sincronizarTabla(oT, aDatos, silent)) {
        if (!flfactppal.iface.pub_appendTextToLogFile(_i.logName_, "Fallo sincronizando " + oT.nombre)) {
          sys.infoMsgBox("Fallo sincronizando " + oT.nombre);
        }
        return false;
      }
      flfactppal.iface.pub_appendTextToLogFile(_i.logName_, "Tabla " + oT.nombre + " sincronizada con �xito");
      _i.aDatos_.push(aDatos);
      aDatos = [];
    }
  } catch (e) {
    sys.infoMsgBox("Error _sincronizar(): " + e);
    return false;
  }

  return true;
}

function sincrocat_sincronizarTabla(oTabla, aResultados, silent)
{
  var _i = this.iface;
  flfactppal.iface.pub_appendTextToLogFile(_i.logName_, "Sincronizando " + oTabla.nombre);
  var tabla = oTabla.tabla;

  var util = new FLUtil;
  var progreso = 0;
  var where = oTabla.filtro;

  _i.conDestino_ = _i.conDestino_ ? _i.conDestino_ : "default";
  _i.conOrigen_ = _i.conOrigen_ ? _i.conOrigen_ : "default";

  var dbO = AQSql.database(_i.conOrigen_);
  var dbD = AQSql.database(_i.conDestino_);

  if (!dbO.isOpen() || !dbD.isOpen()) {
    if (!flfactppal.iface.pub_appendTextToLogFile(_i.logName_, "CONEXI�N CORTADA!")) {
      sys.infoMsgBox("CONEXI�N CORTADA!");
    }
    return false;
  }

  var curOrigen = (oTabla.reverse ? new FLSqlCursor(tabla, _i.conDestino_) : new FLSqlCursor(tabla, _i.conOrigen_));
  var oB = _i.dameOrderByTabla(oTabla);

  var nombreTabla = AQUtil.tableNameToAlias(tabla);
  aResultados["nombreTabla"] = nombreTabla;
  aResultados["sincronizados"] = 0;
  aResultados["sincambios"] = 0;
  aResultados["nuevos"] = 0;
  aResultados["eliminados"] = 0;

  curOrigen.setForwardOnly(true);
  curOrigen.select(where + " ORDER BY " + oB);

  if (_i.curDestino_) {
    delete _i.curDestino_;
  }
  if (_i.curDestinoSin_) {
    delete _i.curDestinoSin_;
  }
  _i.curDestino_ = (oTabla.reverse ? new FLSqlCursor(tabla, _i.conOrigen_) : new FLSqlCursor(tabla, _i.conDestino_));
  _i.curDestinoSin_ = (oTabla.reverse ? new FLSqlCursor(tabla, _i.conOrigen_) : new FLSqlCursor(tabla, _i.conDestino_));

  _i.curDestino_.setActivatedCommitActions(false);
  _i.curDestinoSin_.setActivatedCommitActions(false);
  _i.curDestino_.setActivatedCheckIntegrity(false);
  _i.curDestinoSin_.setActivatedCheckIntegrity(false);
  _i.curDestinoSin_.setForwardOnly(true);
  _i.curDestinoSin_.select(where + " ORDER BY " + oB);

  var claveO, claveD;
  var hayDestino = _i.curDestinoSin_.first();
  var hayOrigen = curOrigen.first();
  if (!silent) {
    flfactppal.iface.pub_creaDialogoProgreso(sys.translate("Sincronizando %1...").arg(tabla), curOrigen.size());
    /**sys.processEvents();
    AQUtil.createProgressDialog(sys.translate("Sincronizando %1...").arg(nombreTabla), curOrigen.size());*/
  } else {
    _i.creaPDSilent(curOrigen.size());
  }

  var mngModO = dbO.managerModules(); // Para evitar que se cierre dbAux
  var mngModD = dbD.managerModules();

  while (hayDestino || hayOrigen) {
    if (!(progreso % 100)) {
      var fakeSha = mngModO.shaOfFile(tabla); // Para evitar que se cierre dbAux
      fakeSha = mngModD.shaOfFile(tabla);
    }
    if (!dbO.isOpen() || !dbD.isOpen()) {
      if (!flfactppal.iface.pub_appendTextToLogFile(_i.logName_, "CONEXI�N CORTADA!")) {
        sys.infoMsgBox("CONEXI�N CORTADA!");
      }
      return false;
    }
    if (hayDestino && hayOrigen) {
      claveD = _i.dameClaveTabla(_i.curDestinoSin_, oTabla);
      claveO = _i.dameClaveTabla(curOrigen, oTabla);
      if (claveD == claveO) {
        if (!_i.copiarRegistroDestino(curOrigen, oTabla, aResultados)) {
          if (!silent) {
            sys.AQTimer.singleShot(0, AQUtil.destroyProgressDialog);
          }
          return false;
        }
        hayOrigen = curOrigen.next();
        if (!silent) {
          AQUtil.setProgress(progreso++);
        } else {
          _i.setProgressPDSilent(progreso++);
        }
        hayDestino = _i.curDestinoSin_.next();
      } else if (claveO > claveD) {
        if (!_i.borrarRegistroDestino(curOrigen, oTabla)) {
          if (!silent) {
            sys.AQTimer.singleShot(0, AQUtil.destroyProgressDialog);
          }
          return false;
        }
        aResultados["eliminados"]++;
        hayDestino = _i.curDestinoSin_.next();
      } else {
        if (!_i.crearRegistroDestino(curOrigen, oTabla)) {
          if (!silent) {
            sys.AQTimer.singleShot(0, AQUtil.destroyProgressDialog);
          }
          return false;
        }
        aResultados["nuevos"]++;
        hayOrigen = curOrigen.next();
        if (!silent) {
          AQUtil.setProgress(progreso++);
        } else {
          _i.setProgressPDSilent(progreso++);
        }
      }
    } else if (!hayOrigen) {
      if (!_i.borrarRegistroDestino(curOrigen, oTabla)) {
        if (!silent) {
          sys.AQTimer.singleShot(0, AQUtil.destroyProgressDialog);
        }
        return false;
      }
      aResultados["eliminados"]++;
      hayDestino = _i.curDestinoSin_.next();
    } else {
      if (!_i.crearRegistroDestino(curOrigen, oTabla)) {
        if (!silent) {
          sys.AQTimer.singleShot(0, AQUtil.destroyProgressDialog);
        }
        return false;
      }
      aResultados["nuevos"]++;
      hayOrigen = curOrigen.next();
      if (!silent) {
        AQUtil.setProgress(progreso++);
      } else {
        _i.setProgressPDSilent(progreso++);
      }
    }
  }
  if (!silent) {
    sys.AQTimer.singleShot(0, AQUtil.destroyProgressDialog);
  }
  if (!_i.afterSincronizarTabla(oTabla, aResultados, silent)) {
    return false;
  }
  return true;
}

function sincrocat_dameClaveTabla(curTabla, oTabla)
{
  var _i = this.iface;

  var mtd = _i.mgr_.metadata(oTabla.tabla);
  var mtdF;
  var clave = "";
  if (oTabla.clave.length == 1 && oTabla.clave[0] == "pk") {
    mtdF = mtd.field(mtd.primaryKey());
    clave = curTabla.valueBuffer(mtd.primaryKey());
    //    if (mtdF.type() == _i.tSTRING_) {
    //      clave = clave.toUpperCase();
    //    }
  } else {
    clave = "";
    for (var i = 0; i < oTabla.clave.length; i++) {
      clave += clave != "" ? "_x_" : "";
      mtdF = mtd.field(oTabla.clave[i]);
      //      if (mtdF.type() == _i.tSTRING_ || mtdF.type() == _i.tDATE_) {
      //        clave += curTabla.valueBuffer(oTabla.clave[i]).toUpperCase();
      //      } else {
      clave += curTabla.valueBuffer(oTabla.clave[i]);
      //      }
    }
  }
  return clave;
}

function sincrocat_dameOrderByTabla(oTabla)
{
  var _i = this.iface;

  var oB;
  var mtd = _i.mgr_.metadata(oTabla.tabla);
  if (oTabla.clave.length == 1 && oTabla.clave[0] == "pk") {
    var mtdF = mtd.field(mtd.primaryKey());
    //    if (mtdF.type() == _i.tSTRING_ || mtdF.type() == _i.tDATE_) {
    //      oB = "UPPER(" + mtd.primaryKey() + ")";
    //    } else {
    oB = mtd.primaryKey();
    //    }
  } else {
    oB = oTabla.clave.join(",");
  }
  return oB;
}

function sincrocat_copiarRegistroDestino(curOrigen, oTabla, aResultados)
{
  var _i = this.iface;
  if (_i.regSincronizado(curOrigen, oTabla)) {
    aResultados["sincambios"]++;
    return true;
  }
  _i.curDestinoSin_.setModeAccess(_i.curDestino_.Edit);
  _i.curDestinoSin_.refreshBuffer();

  var campos = oTabla.camposSincroEdit;
  var totalCampos = campos.length;
  for (var i = 0; i < totalCampos; i++) {
    if (!_i.datosRegistro(curOrigen, _i.curDestinoSin_, campos[i])) {
      return false;
    }
  }
  if (oTabla.camposCalcEdit) {
    for (var i = 0; i < oTabla.camposCalcEdit.length; i++) {
      if (!_i.calculaCampoSincro(_i.curDestinoSin_, oTabla, oTabla.camposCalcEdit[i])) {
        return false;
      }
    }
  }
  aResultados["sincronizados"]++;
  if (!_i.curDestinoSin_.commitBuffer()) {
    return false;
  }
  return true;
}

function sincrocat_regSincronizado(curOrigen, oTabla)
{
  var _i = this.iface;
  var tabla = oTabla.tabla;

  var campos;

  var excepciones = new Object;
  var hayEx = false;
  if (!(oTabla.camposEx.length == 1 && oTabla.camposEx[0] == "none")) {
    hayEx = true;
    for (var i = 0; i < oTabla.camposEx.length; i++) {
      excepciones[oTabla.camposEx[i]] = true;
    }
  }

  if (oTabla.campos.length == 1 && oTabla.campos[0] == "all") {
    campos = _i.dameCamposTabla(tabla);
    campos.shift();
  } else {
    campos = oTabla.campos;
  }
  //  _i.curDestino_.setModeAccess(_i.curDestino_.Browse);
  //  _i.curDestino_.refreshBuffer();

  for (var i = 0; i < campos.length; i++) {
    if (hayEx && campos[i] in excepciones) {
      continue;
    }
    // debug("campos[i] " + campos[i] + " v1 " + curOrigen.valueBuffer(campos[i]) + " v2 " + _i.curDestinoSin_.valueBuffer(campos[i]));
    if (curOrigen.valueBuffer(campos[i]) != _i.curDestinoSin_.valueBuffer(campos[i])) {
      return false;
    }
  }
  return true;
}

function sincrocat_crearRegistroDestino(curOrigen, oTabla)
{
  var _i = this.iface;
  var util: FLUtil = new FLUtil;
  var tabla = curOrigen.table();

  _i.curDestino_.setModeAccess(_i.curDestino_.Insert);
  _i.curDestino_.refreshBuffer();

  var campos = oTabla.camposSincro;
  var totalCampos = campos.length;
  for (var i = 0; i < totalCampos; i++) {
    if (!_i.datosRegistro(curOrigen, _i.curDestino_, campos[i])) {
      return false;
    }
  }
  if (oTabla.camposCalcInsert) {
    for (var i = 0; i < oTabla.camposCalcInsert.length; i++) {
      if (!_i.calculaCampoSincro(_i.curDestino_, oTabla, oTabla.camposCalcInsert[i])) {
        return false;
      }
    }
  }

  if (!_i.curDestino_.commitBuffer()) {
    return false;
  }
  return true;
}

function sincrocat_calculaCampoSincro(curDestino, oTabla, campo)
{
  return false;
}

function sincrocat_dameCamposTabla(tabla)
{
  var campos;
  switch (tabla) {
    case "flgroups": {
      campos = [2, "idgroup", "descripcion"];
      break;
    }
    case "flusers": {
      campos = [3, "iduser", "idgroup", "descripcion"];
      break;
    }
    default: {
      campos = AQUtil.nombreCampos(tabla);
    }
  }
  return campos;
}

function sincrocat_datosRegistro(curO, curD, campo)
{
  var _i = this.iface;
  if (!campo || campo == "") {
    return false;
  }
  var tabla = curO.table();
  switch (tabla) {
    case "impuestos": {
      switch (campo) {
        case "codimpuesto":
        case "descripcion":
        case "iva":
        case "recargo": {
          if (!_i.sincronizarCampo(curO, curD, campo)) {
            return false;
          }
          break;
        }
        default: {
          return true;
        }
      }
      break;
    }
    default: {
      if (!_i.sincronizarCampo(curO, curD, campo)) {
        return false;
      }
    }
  }
  return true;
}

function sincrocat_sincronizarCampo(curO, curD, campo)
{
  var _i = this.iface;
  if (curO.isNull(campo)) {
    curD.setNull(campo);
  } else {
    curD.setValueBuffer(campo, curO.valueBuffer(campo));
  }
  return true;
}

function sincrocat_conectarSinc(conName)
{
  var _i = this.iface;
  try {
    flfactppal.iface.pub_appendTextToLogFile(_i.logName_, "Estableciendo conexi�n " + conName);

    var util: FLUtil = new FLUtil();

    var datosConexion: String = "";
    var nombreBD: String = _i.valorDefectoAlmacen("basedatos");
    datosConexion += "\n" + util.translate("scripts", "Base de datos %1").arg(nombreBD);
    var host: String = _i.valorDefectoAlmacen("servidor");
    datosConexion += "\n" + util.translate("scripts", "Servidor %1").arg(host);
    var driver: String = _i.valorDefectoAlmacen("driver");
    datosConexion += "\n" + util.translate("scripts", "Driver %1").arg(driver);
    var puerto: String = _i.valorDefectoAlmacen("puerto");
    datosConexion += "\n" + util.translate("scripts", "Puerto %1").arg(puerto);


    if (!driver || !nombreBD || !host) {
      if (!flfactppal.iface.pub_appendTextToLogFile(_i.logName_, "Debe indicar los datos de conexi�n a la base de datos Central en la opci�n Configuraci�n de este m�dulo.")) {
        sys.infoMsgBox("Debe indicar los datos de conexi�n a la base de datos Central en la opci�n Configuraci�n de este m�dulo.");
      }
      return false;
    }

    var tipoDriver: String;
    if (sys.nameDriver().search("PSQL") > -1) {
      tipoDriver = "PostgreSQL";
    } else {
      tipoDriver = "MySQL";
    }

    var usuario = _i.valorDefectoAlmacen("usuario");
    var password = _i.valorDefectoAlmacen("contrasena");
    if (!sys.addDatabase(driver, nombreBD, usuario, password, host, puerto, conName)) {
      if (!flfactppal.iface.pub_appendTextToLogFile(_i.logName_, "Error en la conexi�n: " + datosConexion)) {
        sys.infoMsgBox("Error en la conexi�n: " + datosConexion);
      }
      return false;
    }
    _i.establecerConexionesSinc(conName, false);

    flfactppal.iface.pub_appendTextToLogFile(_i.logName_, "Conexi�n " + conName + " establecida con �xito.");
    _i.password_ = "";

    return true;
  } catch (e) {
    sys.infoMsgBox("Error estableciendo la conexi�n: " + e);
    return false;
  }
}

function sincrocat_pedirPassword()
{
  var _i = this.iface;
  _i.password_ = "";

  var f: Object = new FLFormSearchDB("pedirpasswordsincro");
  var cursor: FLSqlCursor = f.cursor();

  cursor.setActivatedCheckIntegrity(false);
  cursor.select();
  if (!cursor.first()) {
    cursor.setModeAccess(cursor.Insert);
  } else {
    cursor.setModeAccess(cursor.Edit);
  }

  f.setMainWidget();
  cursor.refreshBuffer();
  f.exec("id");
}

function sincrocat_establecerConexionesSinc(conOrigen, conDestino)
{
  var _i = this.iface;
  _i.conOrigen_ = conOrigen;
  _i.conDestino_ = conDestino;
  return true;
}

function sincrocat_dameResultadosSincro()
{
  var _i = this.iface;
  var util: FLUtil = new FLUtil();
  var totalDatos: Number = _i.aDatos_.length;
  var observaciones: String = "";
  for (var i: Number = 0; i < totalDatos; i++) {
    observaciones += util.translate("scripts", "%1: %2 nuevos, %3 sincronizados, %4 sin cambios, %5 eliminados").arg(_i.aDatos_[i]["nombreTabla"]).arg(_i.aDatos_[i]["nuevos"]).arg(_i.aDatos_[i]["sincronizados"]).arg(_i.aDatos_[i]["sincambios"]).arg(_i.aDatos_[i]["eliminados"]);
    observaciones += "\n";
  }
  return observaciones;
}

function sincrocat_dameElementoSincro(t)
{
  var o = new Object;
  o.nombre = t;
  o.tabla = undefined;
  o.filtro = "(1 = 1)";
  o.clave = ["pk"];
  o.campos = ["all"];
  o.camposEx = ["none"];
  o.camposExEdit = ["none"];
  o.reverse = false; /// Cambia origen por destino y viceversa
  o.camposCalcInsert = undefined; /// Array de campos que deben calcularse al crear el registro destino
  o.camposCalcEdit = undefined; /// Array de campos que deben calcularse al modificar el registro destino
  o.borradoOff = false; /// No borra registros en la tabla destino
  return o;
}

function sincrocat_dameOrdenTablas(esquema)
{
  var oT;
  switch (esquema) {
    default: {
      oT = ["impuestos", "familias", "articulos"];
    }
  }
  return oT;
}

function sincrocat_dameDatosTabla(t, esquema)
{
  var _i = this.iface;
  var oT;
  switch (t) {
      //    case "articulos": {
      //      oT = _i.dameElementoSincro();
      //      oT.tabla = t;
      //      oT.campos = ["pvp"];
      //      break;
      //    }
    default: {
      oT = _i.dameElementoSincro(t);
      oT.tabla = t;
    }
  }
  return oT;
}

function sincrocat_dameObjetoTabla(t, esquema)
{
  var _i = this.iface;
  var oTabla = _i.dameDatosTabla(t, esquema);
  if (!oTabla) {
    debug("Error al obtener los datos de la tabla tabla " + t);
    return false;
  }
  oTabla.camposSincro = [];
  oTabla.camposSincroEdit = [];

  var excepciones = new Object;
  var hayEx = false;
  if (!(oTabla.camposEx.length == 1 && oTabla.camposEx[0] == "none")) {
    hayEx = true;
    for (var i = 0; i < oTabla.camposEx.length; i++) {
      excepciones[oTabla.camposEx[i]] = true;
    }
  }
  var excepcionesEdit = new Object;
  var hayExEdit = false;
  if (!(oTabla.camposExEdit.length == 1 && oTabla.camposExEdit[0] == "none")) {
    hayExEdit = true;
    for (var i = 0; i < oTabla.camposExEdit.length; i++) {
      excepcionesEdit[oTabla.camposExEdit[i]] = true;
    }
  }

  if (oTabla.campos.length == 1 && oTabla.campos[0] == "all") {
    campos = _i.dameCamposTabla(oTabla.tabla);
    campos.shift();
  } else {
    campos = oTabla.campos;
  }

  for (var i = 0; i < campos.length; i++) {
    if (hayEx && campos[i] in excepciones) {
      continue;
    }
    oTabla.camposSincro.push(campos[i]);
    if (hayExEdit && campos[i] in excepcionesEdit) {
      continue;
    }
    oTabla.camposSincroEdit.push(campos[i]);
  }
  return oTabla;
}


function sincrocat_borrarRegistroDestino(curOrigen, oTabla)
{
  if (oTabla.borradoOff) {
    return true;
  }
  var _i = this.iface;
  _i.curDestinoSin_.setModeAccess(_i.curDestino_.Del);
  _i.curDestinoSin_.refreshBuffer();

  if (!_i.curDestinoSin_.commitBuffer()) {
    return false;
  }
  return true;
}

function sincrocat_afterSincronizarTabla(oTabla, aResultados, silent)
{
  return true;
}

function sincrocat_beforeCommit_stocks(curStock)
{
  var _i = this.iface;
  if (!_i.__beforeCommit_stocks(curStock)) {
    return false;
  }
  if (!_i.controlIdSincroStock(curStock)) {
    return false;
  }
  if (!_i.controlUltMovStock(curStock)) {
    return false;
  }
  return true;
}

function sincrocat_beforeCommit_lineasregstocks(curL)
{
  var _i = this.iface;
  //  if (!_i.__beforeCommit_lineasregstocks(curL)) {
  //    return false;
  //  }
  if (!_i.controlIdSincroRegStock(curL)) {
    return false;
  }
  return true;
}

function sincrocat_controlIdSincroStock(curStock)
{
  switch (curStock.modeAccess()) {
    case curStock.Insert:
    case curStock.Edit: {
      if (curStock.valueBuffer("idsincro") == "" || curStock.isNull("idsincro")) {
        var idSincro = curStock.valueBuffer("codalmacen") + "_" + curStock.valueBuffer("referencia");
        if (flfactppal.iface.pub_extension("tallcol_barcode")) {
          idSincro += "_" + curStock.valueBuffer("barcode");
        }
        curStock.setValueBuffer("idsincro", idSincro);
      }
      break;
    }
  }
  return true;
}

function sincrocat_controlIdSincroRegStock(curL)
{
  switch (curL.modeAccess()) {
    case curL.Insert:
    case curL.Edit: {
      if (curL.valueBuffer("idsincro") == "" || curL.isNull("idsincro")) {
        var idSincroStock = AQUtil.sqlSelect("stocks", "idsincro", "idstock = " + curL.valueBuffer("idstock"));
        if (!idSincroStock) {
          return false;
        }
        var idSincro = curL.valueBuffer("id") + "_" + curL.valueBuffer("hora").toString();
        curL.setValueBuffer("idsincro", idSincro);
        curL.setValueBuffer("idsincrostock", idSincroStock);
      }
      break;
    }
  }
  return true;
}

function sincrocat_controlUltMovStock(curStock)
{
  switch (curStock.modeAccess()) {
    case curStock.Edit: {
      if (curStock.valueBufferCopy("cantidad") == curStock.valueBuffer("cantidad")) {
        break;
      }
      var q = new FLSqlQuery;
      q.setSelect("fechareal, horareal");
      q.setFrom("movistock");
      q.setWhere("idstock = " + curStock.valueBuffer("idstock") + "AND estado = 'HECHO' ORDER BY fechareal DESC, horareal DESC");
      if (!q.exec()) {
        return false;
      }
      if (q.first()) {
        var hora = q.value("horareal");
        var fecha = q.value("fechareal");
        var fechaUltReg = curStock.valueBuffer("fechaultreg");
        if (fechaUltReg) {
          var horaUltReg = curStock.valueBuffer("horaultreg");
          // debug("fechaUltReg " + fechaUltReg);
          // debug("horaUltReg " + horaUltReg);
          // debug("fecha" + fecha);
          // debug("hora " + hora);
          //
          // debug(fecha.toString().left(10) + "T" + hora.toString().right(8));
          // debug(fechaUltReg.toString().left(10) + "T" + horaUltReg.toString().right(8));
          var dMov;
          try {
            dMov = new Date(Date.parse(fecha.toString().left(10) + "T" + hora.toString().right(8)));
          } catch (e) {
            dMov = new Date;
          }
          var dReg;
          try {
            dReg = new Date(Date.parse(fechaUltReg.toString().left(10) + "T" + horaUltReg.toString().right(8)));
          } catch (e) {
            dReg = new Date;
          }
          if (dReg.getTime() > dMov.getTime()) {
            fecha = fechaUltReg;
            hora = horaUltReg;
          }
        }
        curStock.setValueBuffer("fechaultmov", fecha);
        curStock.setValueBuffer("horaultmov", hora);
      }
      break;
    }
  }
  return true;
}
//// SINCRO CATALOGO ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

