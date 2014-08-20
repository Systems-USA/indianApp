//
//  ConexionModalView.m
//  iReflexis
//
//  Created by Jesus Manuel Vigueras Chaparro on 09/12/11.
//  Copyright (c) 2011 Banco Azteca. All rights reserved.
//

#import "Conexion.h"
//#import "Constantes.h"
//#import "JSON.h"
//#import "ConstantesServiciosCreador.h"
//#import "ConstantesMisIncidencias.h"
//#import "Evidencias.h"
//#import "Utils.h"
//#import "ConstantesProduccion.h"
//#import "ModificaURL.h"



@implementation Conexion





@synthesize delegate;
@synthesize nameServiceCall;


#pragma mark - Metodos del indicador


-(NSString *)obtenAmbiente {
    
    return @"";
    
}



#pragma mark Conexion Delegados

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    [webData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data { 
    
    [webData appendData:data];
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    NSLog(@"Error to get service: %@", nameServiceCall);
    [delegate finishConexion:nil withSuccess:NO toNameService:nameServiceCall];
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *) connection
{ 
    
    NSDictionary *diccionary = [NSDictionary dictionary];
    NSString *string = @"";
    
    
    string = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    diccionary = [string JSONValue];
    
    
    
    
    if (diccionario != NULL) {
        
        if ([nombreService isEqualToString:@"projectDetails"] || [nombreService isEqualToString:@"projectDetailAprobador"]) {
            [delegate terminoConexion:[ModificaURL cambiaIPsServicioProjectDetail:diccionario] exito:YES nombreServicio:nombreService];
        }
        else if ([nombreService isEqualToString:@"evidenSuper"]) {
            [delegate terminoConexion:[ModificaURL cambiaIPsServicioEvidenSuper:diccionario] exito:YES nombreServicio:nombreService];
        }
        else if ([nombreService isEqualToString:@"getEvidenciaCreador"]) {
            [delegate terminoConexion:[ModificaURL cambiaIPsServicioGetEvidenciaCreador:diccionario] exito:YES nombreServicio:nombreService];
        }
        else {
            [delegate terminoConexion:diccionario exito:YES nombreServicio:nombreService];
        }
        
        
        
        
        
        
        
    }
    else {
        NSLog(@"Error al generar NSDictionary de respuesta.");
        [delegate terminoConexion:diccionario exito:NO nombreServicio:nombreService];
    }
    
    [cadena release];
    
}



#pragma mark Conexion Metodos

-(NSString *)obtienePath:(NSString *)nombreServicio {
    
    NSString *path = @"";
    
    if ([nombreServicio isEqualToString:@"busca"])
        path = [NSString stringWithFormat:@"%@services/geolocalizacion/getGeo?",DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"obtenerNotificaciones"])
        path = [NSString stringWithFormat:@"%@services/notificacion/obtener?",DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"insertNotificacion"])
        path = [NSString stringWithFormat:@"%@services/notificacion/insertar?",DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"getInfoUsuario"])
        path = [NSString stringWithFormat:@"%@services/videollamadaService/getInfoUsuario?",DIR_SERVICIOS];        
    
    else if ([nombreServicio isEqualToString:@"projectList"])          
        path = [NSString stringWithFormat:@"%@services/initGerente/projectList?",DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"getComments"])
        path = [NSString stringWithFormat:@"%@services/comments/getComments?",DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"Login"])
        path = [NSString stringWithFormat:@"%@services/initGerente/login?",DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"AddComments"])
        path = [NSString stringWithFormat:@"%@services/comments/AddComments?",DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"projectDetails"])
        path = [NSString stringWithFormat:@"%@services/initGerente/projectDetails?",DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"projectDetailsSub"])
        path = [NSString stringWithFormat:@"%@services/initPerfil/projectDetails?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"FetchSurvey"])
        path = [NSString stringWithFormat:@"%@services/encuesta/fetchSurvey?",DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"StatusUpd"])
        path = [NSString stringWithFormat:@"%@services/tareaService/statusUpd?",DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"UpdSurvey"])
        path = [NSString stringWithFormat:@"%@services/encuesta/uptSurvey?",DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"getBorradores"])  // Inician Servicios para Borradores
        path = [NSString stringWithFormat:@"%@services/tareaService/getBorradores?",DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:INSERT_TAREAINFO])//Info inicial Tarea
        path = [NSString stringWithFormat:@"%@services/tareaService/insert?",DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"getPasos"])  // Inician Servicios para Borradores
        path = [NSString stringWithFormat:@"%@services/tareaService/getPasos?",DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"obtenPuestos"])  // Inician Servicios para puestps
        path = [NSString stringWithFormat:@"%@services/lanzamientoService/obtenPuestos?",DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"obtieneCeco"])
        path = [NSString stringWithFormat:@"%@services/lanzamientoService/obtieneCeco?",DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"quiz"])
        path = [NSString stringWithFormat:@"%@services/quizService/fetchQuiz?",DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"insertQuiz"])
        path = [NSString stringWithFormat:@"%@services/quizService/insertQuiz?",DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"fetchQuiz"])
        path = [NSString stringWithFormat:@"%@services/quizService/fetchQuiz?",DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"updateQuiz"])
        path = [NSString stringWithFormat:@"%@services/quizService/updateQuiz?",DIR_SERVICIOS];    
    
    else if([nombreServicio isEqualToString:@"insertGeo"]) 
        path = [NSString stringWithFormat:@"%@services/geolocalizacion/insertGeolocalizacion?",DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"obtenGeo"])
        path = [NSString stringWithFormat:@"%@services/creadorService/sucurTarGeo?",DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"pasosGeo"])
        path = [NSString stringWithFormat:@"%@services/creadorService/pasosGeo?",DIR_SERVICIOS];
    
    else if([nombreServicio isEqualToString:@"updatePaso"])
        path = [NSString stringWithFormat:@"%@services/pasoService/updatePaso?",DIR_SERVICIOS];
    
    else if([nombreServicio isEqualToString:@"getAnexos"])
        path = [NSString stringWithFormat:@"%@services/anexoService/getAnexos?",DIR_SERVICIOS];
    
    else if([nombreServicio isEqualToString:@"getCecoGeo"])
        path = [NSString stringWithFormat:@"%@services/initGerente/getCecoGeo?",DIR_SERVICIOS];
    
    else if([nombreServicio isEqualToString:@"insertSeguimiento"])
        path = [NSString stringWithFormat:@"%@services/geolocalizacion/insertSeguimiento?",DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"getGeo"])
        path = [NSString stringWithFormat:@"%@services/geoSucursal/getGeo?", DIR_SERVICIOS];
    
    else if([nombreServicio isEqualToString:@"getSeguimiento"])
        path = [NSString stringWithFormat:@"%@services/geolocalizacion/getSeguimiento?",DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"insert"])
        path = [NSString stringWithFormat:@"%@services/tareaService/insert?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"insertPaso"])
        path = [NSString stringWithFormat:@"%@services/tareaService/insertPaso?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"insertEncuestaSi"])
        path = [NSString stringWithFormat:@"%@services/encuesta/insertEncuestaSi?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"insertEncuestaNo"])
        path = [NSString stringWithFormat:@"%@services/encuesta/insertEncuestaNo?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"insertaAnexo"])
        path = [NSString stringWithFormat:@"%@services/anexoService/insert?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"liberar"])
        path = [NSString stringWithFormat:@"%@services/lanzamientoService/insert?", DIR_SERVICIOS];
    
    else if([nombreServicio isEqualToString:@"nuevaListaDistribucion"])
        path= [NSString stringWithFormat:@"%@services/ListaDistribucionService/insertLista?", DIR_SERVICIOS];
    
    else if([nombreServicio isEqualToString:@"consultaListaDistribucion"])
        path= [NSString stringWithFormat:@"%@services/ListaDistribucionService/consultaLista?", DIR_SERVICIOS];
    
    else if([nombreServicio isEqualToString:@"agregaListaDistribucion"])
        path = [NSString stringWithFormat:@"%@services/ListaDistribucionService/insertLista?", DIR_SERVICIOS];
    
    else if([nombreServicio isEqualToString:@"eliminaListaDistribucion"])
        path = [NSString stringWithFormat:@"%@services/ListaDistribucionService/updateLista?", DIR_SERVICIOS];
    
    else if([nombreServicio isEqualToString:@"eliminaTiendaListaDistribucion"])
        path = [NSString stringWithFormat:@"%@services/ListaDistribucionService/updateLista?", DIR_SERVICIOS];
    
    else if([nombreServicio isEqualToString:@"getUsr"])
        path = [NSString stringWithFormat:@"%@services/geolocalizacion/getUsr?",DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"eliminaBorrador"])
        path = [NSString stringWithFormat:@"%@services/tareaService/insert?",DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"projectListAprobador"])
        path = [NSString stringWithFormat:@"%@services/initPerfil/projectList?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"projectDetailAprobador"])
        path = [NSString stringWithFormat:@"%@services/initPerfil/projectDetails?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"aprobarTarea"])
        path = [NSString stringWithFormat:@"%@services/updateTarea/update?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"getSitiosInteres"])
        path = [NSString stringWithFormat:@"%@services/sitioInteresService/getSitiosInteres?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"getTemplates"])
        path = [NSString stringWithFormat:@"%@services/TemplateService/consultaTemplates?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"makeTemplate"])
        path = [NSString stringWithFormat:@"%@services/TemplateService/statusTemplate?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"insertEvidencia"])
        path = [NSString stringWithFormat:@"%@services/admonEvidencia/insertEvidencia?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"buscaTienda"])
        path = [NSString stringWithFormat:@"%@services/tiendaProx/buscaTienda?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"insertEvaluacion"])
        path = [NSString stringWithFormat:@"%@services/evaluacionService/insert?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"tareasRandom"])
        path = [NSString stringWithFormat:@"%@services/storeWalk/swTareasRandom?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"tareasAsignadas"])
        path = [NSString stringWithFormat:@"%@services/storeWalk/swTareasAsignadas?", DIR_SERVICIOS];
    
    // JGFV Grito de Guerra fuera de SW
    else if ([nombreServicio isEqualToString:@"swGritoDeGuerra"])
        path = [NSString stringWithFormat:@"%@services/storeWalk/swGritoDeGuerra?", DIR_SERVICIOS];
    
    else if([nombreServicio isEqualToString:@"gritosGuerra"])
        path = [NSString stringWithFormat:@"%@services/GGService/obtenPendientes?",DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"lanzarTemplate"])
        path = [NSString stringWithFormat:@"%@services/TemplateService/lanzarTemplate?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"gritosGuerraNoSupervisados"]) 
        path = [NSString stringWithFormat:@"%@services/supervision/supervisaOpciones?",DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"gritosGuerraSinVisitarTienda"]) 
        path = [NSString stringWithFormat:@"%@services/supervision/supervisaOpciones?",DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"mensajeriaHome"])
        path = [NSString stringWithFormat:@"%@services/comments/getMensajesByUsr?",DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"tareasNoEjecutadas"])
        path = [NSString stringWithFormat:@"%@services/tareaService/tareasNoEjecutadas?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"tareasNoTerminadas"])
        path = [NSString stringWithFormat:@"%@services/admonIndicadorTarea/getTarea?", DIR_SERVICIOS];    
    
    else if ([nombreServicio isEqualToString:@"supervisaOpciones"])
        path = [NSString stringWithFormat:@"%@services/supervision/supervisaOpciones?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"misIncidencias"])
        path = [NSString stringWithFormat:@"%@services/supervision/contadorSupervision?",DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"getTarea"] || [nombreServicio isEqualToString:TSUP_NO_CUMPLIO] || [nombreServicio isEqualToString:TSUP_CUMPLIO] || [nombreServicio isEqualToString:T_NO_LIB_JPLAZA] || [nombreServicio isEqualToString:TTERMINADASUP_NO_CUMPLIO] || [nombreServicio isEqualToString:TNOTERMINADAS])
        path = [NSString stringWithFormat:@"%@services/admonIndicadorTarea/getTarea?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"costeoIncidenciasGet"])
        path = [NSString stringWithFormat:@"%@services/costeoIncidencias/consulta", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"costeoIncidenciasUpdate"])
        path = [NSString stringWithFormat:@"%@services/costeoIncidencias/actualiza?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"getTareasSub"])
        path = [NSString stringWithFormat:@"%@services/tareaService/getTareasSub?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"getVersionApp"])
        path = [NSString stringWithFormat:@"%@services/CtrlVersion/select?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"contadoresSupervision"])
        path = [NSString stringWithFormat:@"%@services/supervision/contadoresSupervision?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"rankingUsr"])
        path = [NSString stringWithFormat:@"%@services/ranking/rankingUsr?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"tareasSuperNoCumplio"])
        path = [NSString stringWithFormat:@"%@services/admonIndicadorTarea/getTarea?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"pasosRealizadosFuera"])
        path = [NSString stringWithFormat:@"%@services/indicadorPaso/getIndicador?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"insertGeoSucursal"])
        path = [NSString stringWithFormat:@"%@services/geoSucursal/insertGeoSucursal?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"quizEval"])
        path = [NSString stringWithFormat:@"%@services/quizEval/eval?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"getListaKPIs"])
        path = [NSString stringWithFormat:@"%@services/admonIndicadorTarea/getTareasCreador?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"getTareasEstatus"])
        path = [NSString stringWithFormat:@"%@services/admonIndicadorTarea/getTareasEstatus?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"getHeadTarea"])
        path = [NSString stringWithFormat:@"%@services/admonIndicadorTarea/getHeadTarea?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"getTareasEncKPI"])
        path = [NSString stringWithFormat:@"%@services/admonIndicadorTarea/getTareasEnc?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"getComentariosKPI"])
        path = [NSString stringWithFormat:@"%@services/admonIndicadorTarea/getTareasComm?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"pasosFueraKPI"])
        path = [NSString stringWithFormat:@"%@services/kpiEstadist/pasosFZ?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"getTareasDetalleSts"])
        path = [NSString stringWithFormat:@"%@services/admonIndicadorTarea/getTareasDetalleSts?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"getTSupervisadas"])
        path = [NSString stringWithFormat:@"%@services/indTSupervisadas/getTSupervisadas?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"getDSupervisadas"])
        path = [NSString stringWithFormat:@"%@services/indTSupervisadas/getDSupervisadas?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"getTSupervisa2"])
        path = [NSString stringWithFormat:@"%@services/indTSupervisa2/getTSupervisa2?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"getDSupervisa2"])
        path = [NSString stringWithFormat:@"%@services/indTSupervisa2/getDSupervisa2?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"cuestionariosNoA"])
        path = [NSString stringWithFormat:@"%@services/quizEval/respData?", DIR_SERVICIOS];    
    
    else if ([nombreServicio isEqualToString:@"getTareasRFueraDVigencia"])
        path = [NSString stringWithFormat:@"%@services/indTCaducas/getTCaducas?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"getTareasRFueraDVigencia2"])
        path = [NSString stringWithFormat:@"%@services/indTCaducas/getTCaduca2?", DIR_SERVICIOS];    
    
    else if ([nombreServicio isEqualToString:@"evidenSuper"])
        path = [NSString stringWithFormat:@"%@services/kpiEstadist/evidenSuper?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"getPlazaTarea"])
        //Nuevo Servicio
        path = [NSString stringWithFormat:@"%@services/KpiTarea/getKpiTarea?", DIR_SERVICIOS];

    else if ([nombreServicio isEqualToString:@"getPlazaTareaOld"])
        // Servicio Anterior JF 25/Abr/2013  Se cambia por lentitud en la respuesta
        path = [NSString stringWithFormat:@"%@services/PlazasTarea/getPlazaTarea?", DIR_SERVICIOS];
        
    else if ([nombreServicio isEqualToString:@"kpiEstadist"])
        path = [NSString stringWithFormat:@"%@services/kpiEstadist/estJefes?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"getResumenCreador"])
        path = [NSString stringWithFormat:@"%@services/IndiTarea/getCont?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"initTCerradas"])
        path = [NSString stringWithFormat:@"%@services/initTCerradas/projectList?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"insertKpiTime"])
        path = [NSString stringWithFormat:@"%@services/seguimientoCreador/insertSeguimientoCreador?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"getKpiTime"])
        path = [NSString stringWithFormat:@"%@services/seguimientoCreador/getSeguimientoCreador?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"fecha"])
        path = [NSString stringWithFormat:@"%@services/initGerente/fecha?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"getCheckList"])
        path = [NSString stringWithFormat:@"%@services/chklist/getCheckList?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"insertRespuesta"])
        path = [NSString stringWithFormat:@"%@services/chklist/insertRespuesta?", DIR_SERVICIOS];  
    
    else if ([nombreServicio isEqualToString:@"insertEvalCheck"])
        path = [NSString stringWithFormat:@"%@services/StatusCheckList/insertSCheckList?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"getListaCheckList"])
        path = [NSString stringWithFormat:@"%@services/chklist/getReporte?", DIR_SERVICIOS];
    
    else if ([nombreServicio isEqualToString:@"getPreguntasCheckList"])
        path = [NSString stringWithFormat:@"%@services/chklist/getReporte?", DIR_SERVICIOS];    
    
    // JGFV Servicios KPI GEO TAREAS   
    else if ([nombreServicio isEqualToString:@"obtenGeoTareaKPI"])
        path = [NSString stringWithFormat:@"%@services/geolocalizacion/getGeoTarea?", DIR_SERVICIOS];    
    
    // JGFV Servicios KPI GEO CECOS  
    else if ([nombreServicio isEqualToString:@"getGeoCeco"])
        path = [NSString stringWithFormat:@"%@services/geoPlaza/getCoordenadas?", DIR_SERVICIOS];    
    
    // JGFV Servicios Panel MGR    
    else if ([nombreServicio isEqualToString:@"getDispersionPanel"])
        //path = [NSString stringWithFormat:@"%@services/MesaCtrlMGR/getGraficaDispersion?", DIR_SERVICIOS];    
        path = [NSString stringWithFormat:@"%@services/dispersion/consultaFiltrada?", DIR_SERVICIOS];    
    
    //MRGN - EVIDENCIAS DEL CREADOR 
    else if ([nombreServicio isEqualToString:@"getTareasPanel"])
        path = [NSString stringWithFormat:@"%@services/MesaCtrlMGR/getIndicadores?", DIR_SERVICIOS];   
    
    //MRGN - EVIDENCIAS DEL CREADOR
    else if ([nombreServicio isEqualToString:@"getEvidenciaCreador"]) {
        path = [NSString stringWithFormat:@"%@services/verEvidencia/getEvidencia?", DIR_SERVICIOS];
    }
    
    else if ([nombreServicio isEqualToString:@"insertEvidenciaCreador"]){
        path = [NSString stringWithFormat:@"%@services/verEvidencia/insertEvidencia?", DIR_SERVICIOS];
    }
    
    //MRGN - INSERTA GEOLOCALIZACION DE TAREA
    else if ([nombreServicio isEqualToString:@"insertGeoTarea"]) {
        path = [NSString stringWithFormat:@"%@services/geolocalizacion/insertGeoTarea?", DIR_SERVICIOS];
    }
    
    //MRGN - SERVICIO PARA FILTRAR POR DISTRITO O PLAZAS
    else if ([nombreServicio isEqualToString:@"cecoSubService"]) {
        path = [NSString stringWithFormat:@"%@services/cecoSubService/getCecoSub?", DIR_SERVICIOS];
    }
    
    //VARR - Agregado el servicio DEMG Filtrado
    else if([nombreServicio isEqualToString:@"getMgt"])
        path = [NSString stringWithFormat:@"%@services/Migente/getMgt?",DIR_SERVICIOS];
    
    //MRGN - CONSULTA EL SERVICIO PARA 'INDICADOR SEMANAL'
    else if ([nombreServicio isEqualToString:@"indicadorSemanalV"]) {
        path = [NSString stringWithFormat:DATOS_INDICADORSEMANALV, DIR_INDICADORSEMANAL_V];
    }
    
    //MRGN - LOG BRIDGE
    else if ([nombreServicio isEqualToString:@"logBridge"]) {
        path = [NSString stringWithFormat:@"%@services/regActividad/inRegistro?",DIR_SERVICIOS];
    }
    
    //MRGN - FECHA EXPIRACION DE TAREAS
    else if ([nombreServicio isEqualToString:@"inFtermino"]) {
        path = [NSString stringWithFormat:@"%@services/fTermino/inFtermino?",DIR_SERVICIOS];
    }
    
    //MRGN - CONSULTA EL SERVICIO PARA 'INDICADOR DIARIO'
    else if ([nombreServicio isEqualToString:@"indicadorDiario"]) {
        //path = [NSString stringWithFormat:@"%@upload/elektra/reporteDiarioPlazasDesa/", DIR_INDICADORSEMANAL_V];
        path = [NSString stringWithFormat:DATOS_INDICADORDIARIO, DIR_INDICADORSEMANAL_V];
    }
    
    //NUEVO - SERVICIO PARA RANKING
    //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    else if ([nombreServicio isEqualToString:@"getRankReporteDiario"]) {
        path = [NSString stringWithFormat:@"%@services/correo/getRankReporteDiario?",DIR_SERVICIOS];
    }
    //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    
    
    //MRGN - CONSULTA EL REPORTE INICIAL DE 'TAREAS VIGENTES PENDIENTES POR EJECUTAR'
    else if ([nombreServicio isEqualToString:@"getTareasHoy"]) {
        
        path = [NSString stringWithFormat:@"%@services/rankTareasService/getTareasHoy?",DIR_SERVICIOS];
        
    }
    
    //MRGN - CONSULTA EL REPORTE INICIAL DE 'TAREAS VIGENTES PENDIENTES POR EJECUTAR'
    else if ([nombreServicio isEqualToString:@"getTareasHoyDet"]) {
        
        path = [NSString stringWithFormat:@"%@services/rankTareasService/getTareasHoyDet?",DIR_SERVICIOS];
        
    }
    
    //MRGN - CONSULTA EL REPORTE INICIAL DE 'TAREAS VIGENTES PENDIENTES POR EJECUTAR'
    else if ([nombreServicio isEqualToString:@"getBannerftp"]) {
        
        path = [NSString stringWithFormat:DATOS_BANNERINFERIOR, DIR_INDICADORSEMANAL_V];
        
    }
    
    //NUEVO - SERVICIO PARA RANKING
    //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    else if ([nombreServicio isEqualToString:@"getRankReporteDiario"]) {
        path = [NSString stringWithFormat:@"%@services/correo/getRankReporteDiario?",DIR_SERVICIOS];
    }
    //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    
    //VARR - Ocultar mensajes y conversaciones en mensajeria
    //10.51.144.6:8080/restService/services/comments/eliminaComments?projectId=131247&toId=002266&fromId=543414&idComent=0&op=5
    else if ([nombreServicio isEqualToString:@"eliminaComments"]) {
        
        path = [NSString stringWithFormat:@"%@services/comments/eliminaComments?",DIR_SERVICIOS];
        
    }
    
    //VARR - Cambia las fechas de una tarea
    //10.51.193.99:28080/ServicioRest/services/storeWalk/swupdateTarea?idTarea=131338&fechaIni=20130612&fechaFin=20130627&activo=1
    else if ([nombreServicio isEqualToString:@"upadateFechasTarea"]) {
        
        path = [NSString stringWithFormat:@"%@services/storeWalk/swupdateTarea?",DIR_SERVICIOS];
        
    }
    
    // 11/Jul/2013  Listado Todos los  Negocios
    else if ([nombreServicio isEqualToString:@"getListadoNegocios"]) {
        
        path = [NSString stringWithFormat:@"%@services/admonNegocio/getNegocio?",DIR_SERVICIOS];
        
    }
    
    // 15/Jul/2013 Listado de Negocios por Usuario
    else if ([nombreServicio isEqualToString:@"getListadoNegociosUsuario"]) {
        
        path = [NSString stringWithFormat:@"%@services/catLanzamiento/negocioPorUsuario?",DIR_SERVICIOS];
        
    }

    // 15/Jul/2013 Listado de Canales por Negocio
    else if ([nombreServicio isEqualToString:@"getListadoCanales"]) {
        
        path = [NSString stringWithFormat:@"%@services/catLanzamiento/canalesPorNegocio?",DIR_SERVICIOS];
        
    }
    
    
    //MRGN - CREAR ID DE CHECKLIST
    else if ([nombreServicio isEqualToString:@"genera"]){
        path = [NSString stringWithFormat:@"%@services/chklist/genera?",DIR_SERVICIOS];
    }
    
    //MRGN - PARA INSERTAR LAS PREGUNTAS DEL PASO CON CHECK LIST
    else if ([nombreServicio isEqualToString:@"insertPregunta"]){
        path = [NSString stringWithFormat:@"%@services/chklist/insertPregunta?",DIR_SERVICIOS];
    }
    
    //MRGN - CONSULTA EL SERVICIO PARA 'INDICADOR POR UNIDAD DE NEGOCIO'
    else if ([nombreServicio isEqualToString:@"indicadorUnidadNegocio"]) {
        path = [NSString stringWithFormat:DATOS_REPORTEUN, DIR_INDICADORSEMANAL_V];
    }
    
    //VARR - Banner Avance de Tareas
    else if ([nombreServicio isEqualToString:@"bannerAvanceTareas"]) {
        path = [NSString stringWithFormat:@"%@services/dispersion/consulta?",DIR_SERVICIOS];
    }
    
    
    //MRGN - INSERTA COMENTARIOS AL MOMENTO DE RECHAZAR UNA TAREA
    else if ([nombreServicio isEqualToString:@"insertar"]) {
        
        path = [NSString stringWithFormat:@"%@services/mensajesAprobador/insertar?",DIR_SERVICIOS];
        
    }
    
    //MRGN - CONSULTA MENSAJES POR TAREA
    else if ([nombreServicio isEqualToString:@"consultar"]) {
        
        path = [NSString stringWithFormat:@"%@services/mensajesAprobador/consultar?",DIR_SERVICIOS];
        
    }
    
    //MRGN - CONSULTA LOS APROBADORES DE LA TAREA
    else if ([nombreServicio isEqualToString:@"aprobadores"]) {
        
        path = [NSString stringWithFormat:@"%@services/aprobadores/consultaTarea?",DIR_SERVICIOS];
        
    }
    
    //VARR - Login Llave Back
    else if ([nombreServicio isEqualToString:@"validaLlave"]){
        path = [NSString stringWithFormat:@"%@services/llaveMaestra/validaLlave?", DIR_SERVICIOS];
    }
    
    //MRGN - ENVIA CORREO DE APROBACION O RECHAZO DE TAREA
    else if ([nombreServicio isEqualToString:@"avisoAprobacion"]) {
        
        path = [NSString stringWithFormat:@"%@services/detAprobacion/avisoAprobacion?",DIR_SERVICIOS];
        
    }
    
    
    //MRGN - ENVIA CORREO DE LIBERACION DE TAREA
    else if ([nombreServicio isEqualToString:@"avisoCreacion"]) {
        
        path = [NSString stringWithFormat:@"%@services/detAprobacion/avisoCreacion?",DIR_SERVICIOS];
        
    }
    
    //MRGN - OBTENER LAS TAREAS DEL PERSONAL 
    else if ([nombreServicio isEqualToString:@"tareasPendientesSub"]) {
        
        path = [NSString stringWithFormat:@"%@services/tareaService/tareasPendientesSub?",DIR_SERVICIOS];
        
    }
    
    //MRGN - SERVICIO PARA RANKING POR UNIDAD DE NEGOCIO
    else if ([nombreServicio isEqualToString:@"getRankReporteNegocio"]) {
        
        path = [NSString stringWithFormat:@"%@services/correo/getRankReporteNegocio?",DIR_SERVICIOS];
        
    }
    
    //MRGN - SERVICIO PARA INSERTAR LA FECHA DE APROBACION EN EL PROJECTLIST
    else if ([nombreServicio isEqualToString:@"insertaAprobacion"]) {
        
        path = [NSString stringWithFormat:@"%@services/AprobacionTareaService/insertar?",DIR_SERVICIOS];
        
    }
    
    //AB Contador Tareas pendientes
    else if ([nombreServicio isEqualToString:@"contadorTareas"]) {
        
        path = [NSString stringWithFormat:@"%@services/ConTareasPend/contadorTareas?",DIR_SERVICIOS];
        
    }
    
    //AB Subordinados
    else if ([nombreServicio isEqualToString:@"subordinados"]) {
        
        path = [NSString stringWithFormat:@"%@services/catLanzamiento/subordinados?",DIR_SERVICIOS];
        
    }
    
    //VARR - Login consulta de usuario y pass - //10.51.193.99:28080/ServicioRest/services/EncPasswdService/consulta?datos={"idUsuario":"811169","password":"1234610"}
    else if ([nombreServicio isEqualToString:@"loginBridge"]) {
        
        path = [NSString stringWithFormat:@"%@services/EncPasswdService/consulta?",DIR_SERVICIOS];
        
    }
    
    //VARR - Login inserta nuevo password - //10.51.193.99:28080/ServicioRest/services/EncPasswdService/inserta?datos={"idUsuario":"551285","password":"551285"}
    else if ([nombreServicio isEqualToString:@"insertPass"]) {
        
        path = [NSString stringWithFormat:@"%@services/EncPasswdService/inserta?",DIR_SERVICIOS];
        
    }
    
    //VARR - Actualiza el password - //10.51.193.99:28080/ServicioRest/services/EncPasswdService/actualiza?datos={"idUsuario":"811169","password":"1234610"}
    else if ([nombreServicio isEqualToString:@"updatePass"]) {
        
        path = [NSString stringWithFormat:@"%@services/EncPasswdService/actualiza?",DIR_SERVICIOS];
        
    }
    
    //MRGN - Servicio para obtener las plazas a partir de una Unidad de Negocio
    else if ([nombreServicio isEqualToString:@"obtienePlazas"]) {
        
        path = [NSString stringWithFormat:@"%@services/GetRepGG_ST/GetInferior?",DIR_SERVICIOS];
        //path = [NSString stringWithFormat:@"%@services/GetRepGG_ST/GetInferior?", DIR_SERVICIOS_TERCERA];
        
    }
    
    //MRGN - Servicio para obtener los distritales y sus visitas a tienda
    else if ([nombreServicio isEqualToString:@"obtieneVisitaSucursal"]) {
        
        path = [NSString stringWithFormat:@"%@services/GetRepGG_ST/GetInfo?",DIR_SERVICIOS];
        //path = [NSString stringWithFormat:@"%@services/GetRepGG_ST/GetInfo?", DIR_SERVICIOS_TERCERA];
        
    }
    
    //MRGN - OBTIENE EL REPORTE DE VISITA A SUCURSAL POR UNIDAD DE NEGOCIO
    else if ([nombreServicio isEqualToString:@"visitaSucursalReporte"]) {
        
        path = [NSString stringWithFormat:@"%@services/GetRepGG_ST/getRankReporteNegocio?",DIR_SERVICIOS];
        //path = [NSString stringWithFormat:@"%@services/GetRepGG_ST/getRankReporteNegocio?", DIR_SERVICIOS_TERCERA];
        
    }
    
    //MRGN - OBTIENE EL REPORTE DE VISITA A SUCURSAL POR UNIDAD DE NEGOCIO
    else if ([nombreServicio isEqualToString:@"sucursalesPorSupervisar"]) {
        
        path = [NSString stringWithFormat:@"%@services/GetRepGG_ST/GetTInferior?",DIR_SERVICIOS];
        //path = [NSString stringWithFormat:@"%@services/GetRepGG_ST/GetTInferior?", DIR_SERVICIOS_TERCERA];
        
    }
    
    /*
     Contacto Mensajeria
     //10.51.193.99:28080/ServicioRest/services/ContactoMensajeria/insertaContacto?idUsuario=530802&contacto=jblanquel&Uuid=255852525588
     //10.51.193.99:28080/ServicioRest/services/ContactoMensajeria/actualizaContacto?idUsuario=530802&contacto=jblanquel&Uuid=255852525588
     //10.51.193.99:28080/ServicioRest/services/ContactoMensajeria/consultaContacto?idUsuario=530802
     */
    
    //AB insertaContacto
    else if ([nombreServicio isEqualToString:@"insertaContacto"]) {
        
        path = [NSString stringWithFormat:@"%@services/ContactoMensajeria/insertaContacto?",DIR_SERVICIOS];
        
    }
    //AB actualizaContacto
    else if ([nombreServicio isEqualToString:@"actualizaContacto"]) {
        
        path = [NSString stringWithFormat:@"%@services/ContactoMensajeria/actualizaContacto?",DIR_SERVICIOS];
        
    }
    
    //AB consultaContacto
    else if ([nombreServicio isEqualToString:@"consultaContacto"]) {
        
        path = [NSString stringWithFormat:@"%@services/ContactoMensajeria/consultaContacto?",DIR_SERVICIOS];
        
    }
    
    //10.63.100.40/adminReflexis/Servicio/EKT/consultaRH?Datos={"Empleado":"628819"}
    //AB consultaRH
    else if ([nombreServicio isEqualToString:@"consultaRH"]) {
        
        path = [NSString stringWithFormat:@"%@Servicio/EKT/consultaRH?",DIR_ADMIN];
        
    }
    
    //10.51.193.99:28080/ServicioRest/services/GeneraPasswordService/generaContrasena?idUsuario=743930&len=15
    //AB generarPass
    
    else if ([nombreServicio isEqualToString:@"generarPass"]) {
        
        path = [NSString stringWithFormat:@"%@services/GeneraPasswordService/generaContrasena?",DIR_SERVICIOS];
        
    }
    
    //VARR - Servicio que trae las tareas de Grito de Guerra y Store Walk
    else if ([nombreServicio isEqualToString:@"projectListDistrital"]) {
        
        //VARR - Mejora del servicio, se remplaza "projectListDistrital" por "projectListDistritalV2"
        //path = [NSString stringWithFormat:@"%@services/tareasDistritales/projectListDistrital?", DIR_SERVICIOS];
        path = [NSString stringWithFormat:@"%@services/tareasDistritales/projectListDistritalV2?", DIR_SERVICIOS];
    }
    
    //VARR - Servicio que cierra una tarea de Grito de Guerra
    else if ([nombreServicio isEqualToString:@"insertaGG"]) {
        path = [NSString stringWithFormat:@"%@services/tareasDistritales/insertaGG?", DIR_SERVICIOS];
        
    }
    
    //VARR - Servicio que cierra una tarea Especial (VAS o mercancias)
    else if ([nombreServicio isEqualToString:@"cerrarTareaEspecial"]) {
        path = [NSString stringWithFormat:@"%@services/tareasDistritales/cerrarTareaEspecial?", DIR_SERVICIOS];
        
    }
    
    //VARR - Servicio devuelve los GG pendientes por ejecutar
    else if ([nombreServicio isEqualToString:@"gritoGuerraPendiente"]) {
        path = [NSString stringWithFormat:@"%@services/tareasDistritales/listaTiendas?", DIR_SERVICIOS];
        
    }
    
    //VARR - Servicio que cierra una tarea de tipo CKL para visita a sucursal
    else if ([nombreServicio isEqualToString:@"insertaBitCKL"]) {
        path = [NSString stringWithFormat:@"%@services/BitacoraCheckList/insertaBitCKL?", DIR_SERVICIOS];
        
    }
    
    //VARR - Servicio que cierra un paso de tipo CKL de una tarea tipo CKL para la visita a sucursal
    else if ([nombreServicio isEqualToString:@"insertaPasoCKL"]) {
        path = [NSString stringWithFormat:@"%@services/PasoCheckList/insertaPasoCKL?", DIR_SERVICIOS];
        
    }
    
    //VARR - Inserta las coordenadas para saber si se hizo un SW
    else if([nombreServicio isEqualToString:@"insertSeguimientoVisita"]){
        path = [NSString stringWithFormat:@"%@services/geolocalizacion/insertSeguimiento?",DIR_SERVICIOS];
    }
    
    //VARR - Servicio que cierra un paso de tipo CKL de una tarea tipo CKL para la visita a sucursal
    else if ([nombreServicio isEqualToString:@"consultaProjectCkl"]) {
        path = [NSString stringWithFormat:@"%@services/tareasDistritales/consultaProjectCkl?", DIR_SERVICIOS];
        
    }
    
    //VARR - Servicio que trae las coordenadas de las tiendas pertenecientes a un distrital. Usado en VAS
    else if ([nombreServicio isEqualToString:@"tiendasDistrital"]) {
        path = [NSString stringWithFormat:@"%@services/tiendaProx/tiendasDistrital?", DIR_SERVICIOS];
    }
    
    //LASM - Servicio que trae las tiendas visitadas por un distrital en una fecha. Usado en DEMG
    else if ([nombreServicio isEqualToString:@"getReportTRCTiendasVisitadas"]) {
        path = [NSString stringWithFormat:@"%@services/repVisSuc/getReportTRCTiendasVisitadas?", DIR_SERVICIOS];
    }
    //VARR - Servicio que trae los datos de una encuesta (Checklist) por pregunta
    else if ([nombreServicio isEqualToString:@"kpiDistritales"]) {
        path = [NSString stringWithFormat:@"%@services/KpiChecklistService/kpiDistritales?", DIR_SERVICIOS];
    }
    
    return path;
    
    
    
}

-(void)ejecutarServicio:(NSString *)nombreServicio conParametros:(NSMutableDictionary *)parametros {
    
    if ([nombreServicio isEqualToString:@"insertSeguimiento"] && !kDEMGInsertCoordenada) {
        [delegate terminoConexion:[NSDictionary dictionary] exito:NO nombreServicio:nombreService];
        return;
    }
    
    if (parametros == nil) {
        
        parametros = [[[NSMutableDictionary alloc] init]autorelease];
    }
    
    NSMutableString *parametrosString = [[[NSMutableString alloc] init] autorelease];
    
    nombreService = nombreServicio;
    
    NSString *direccionServicio = [self obtienePath:nombreServicio];
    
    [parametrosString appendString:direccionServicio];
    
    if ([nombreServicio isEqualToString:@"indicadorSemanalV"] || [nombreServicio isEqualToString:@"indicadorDiario"] || [nombreServicio isEqualToString:@"getBannerftp"] || [nombreServicio isEqualToString:@"14718"]  || [nombreServicio isEqualToString:@"indicadorUnidadNegocio"] ) {
        
        for(NSString *key in parametros) {
            
            NSString * value = [parametros objectForKey:key];
            
            value = [value stringByReplacingOccurrencesOfString:@"##" withString:@"/"];
            
            [parametrosString appendString:value];
            [parametrosString appendString:@"&"];
        }
        
    } 
    else if ([nombreServicio isEqualToString:@"getMgt"]) {
        
        for(NSString *key in parametros) {
            
            NSString * value = [parametros objectForKey:key];
            
            [parametrosString appendString:key];
            [parametrosString appendString:@"="];
            
            value = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
            value = [value stringByReplacingOccurrencesOfString:@"Á" withString:@"A"];
            value = [value stringByReplacingOccurrencesOfString:@"É" withString:@"E"];
            value = [value stringByReplacingOccurrencesOfString:@"Í" withString:@"I"];
            value = [value stringByReplacingOccurrencesOfString:@"Ó" withString:@"O"];
            value = [value stringByReplacingOccurrencesOfString:@"Ú" withString:@"U"];
            value = [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            
            [parametrosString appendString:value];
            [parametrosString appendString:@"&"];
        }
    }
    else {
        
        for(NSString *key in parametros) {
            
            NSString * value = [parametros objectForKey:key];
            
            [parametrosString appendString:key];
            [parametrosString appendString:@"="];
            
            value = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,  (CFStringRef)value,  NULL,  (CFStringRef)@"!*'’\"();:@&=+$,/?%#[]%", kCFStringEncodingUTF8); // kCFStringEncodingISOLatin1
            
            [parametrosString appendString:value];
            [parametrosString appendString:@"&"];
            
        }
        
    }
    
    
    NSRange ultimoCaracter=[parametrosString rangeOfString:@"&" options:NSBackwardsSearch];
    
    if (ultimoCaracter.length > 0) {
        
        [parametrosString deleteCharactersInRange:ultimoCaracter];
    }
    
    NSMutableURLRequest *peticion=[NSURLRequest requestWithURL:[NSURL URLWithString:parametrosString]];
    
    NSLog(@"Serivicio a ejecutar: %@",nombreServicio);
    NSLog(@"URL codificada: %@ ",parametrosString);
    
    [self conectar:peticion];
    
} 

-(void)conectar:(NSMutableURLRequest *)req {
    
    conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    
    if (conn) {
        
        webData = [[NSMutableData data] retain];
    }
}

-(void)controlaErrorDeConexionParaServicio{
    
    if ([nombreService isEqualToString:@"buscaTienda"]) {
        [delegate terminoConexion:nil exito:NO nombreServicio:nombreService];
    }
    
}


#pragma mark - Delegado UIAlertView

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
}


#pragma mark - View lifecycle

-(id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
    
}

-(void)viewDidLoad {
    
    [super viewDidLoad];
}

-(void)viewDidUnload {
    
    [self setLabel:nil];
    [super viewDidUnload];
    
    self.indicador = nil;
    self.nombreService = nil;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}


-(void)dealloc {
    
    [indicador release];
    [nombreService release];
    delegate = nil;
    
    [label release];
    [super dealloc];
    
}

@end