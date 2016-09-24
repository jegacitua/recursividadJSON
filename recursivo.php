<?php

	$conexion = mysqli_connect('localhost','admin','admin','db_departamento');	
	
	$jsondata = array();
	
	
	//INICIO FUNCION RECURSIVA		
	function recursivo($id, $data, $hijos){
		
		$sql1 = "SELECT
				   ta_unidad_activa.id_unidad
				  ,ta_unidad_activa.nombre_unidad_activa
				  ,(SELECT COUNT(*) FROM ta_unidad_padre 
				   WHERE ta_unidad_padre.id_unidad_depende = ta_unidad_activa.id_unidad
				   AND ta_unidad_padre.estado_unidad_padre = 1) AS 'HIJOS'
				 FROM
				  ta_unidad_activa
				 WHERE
				  ta_unidad_activa.id_unidad = ".$id."
				  AND ta_unidad_activa.estado_unidad_activa = 1";
		//echo $sql1;
		//exit;
		
		$Result = mysqli_query($conexion,$sql1);		 

		if($Result){
			if(mysqli_num_rows($Result) > 0){
				while($row = mysqli_fetch_object($Result)){
					
					if($row->HIJOS > 0){
						$data[] = array("ID_UNIDAD"         		=> $row->id_unidad,
										"NOMBRE_UNIDAD_ACTIVA"  	=> $row->nombre_unidad_activa,
										"HIJOS"						=> '[]');

					}else{
						$data[] = array("ID_UNIDAD"         		=> $row->id_unidad,
										"NOMBRE_UNIDAD_ACTIVA"  	=> $row->nombre_unidad_activa,
										"HIJOS"						=> '[]');
					}
					
				}


				$sql2 = "SELECT
						   ta_unidad_activa.id_unidad
						  ,ta_unidad_activa.nombre_unidad_activa
						 FROM
						  ta_unidad_padre, ta_unidad_activa
						 WHERE
						  ta_unidad_padre.id_unidad_depende = ".$id."
						  AND ta_unidad_padre.id_unidad = ta_unidad_activa.id_unidad";
				//echo $sql2;
				//exit;
				
				$Result2 = mysqli_query($conexion,$sql2);
				
				if($Result2){
					if(mysqli_num_rows($Result2)>0){
						while($row2 = mysqli_fetch_object($Result2)){
							$data = recursivo($row2->id_unidad, $data, NULL);
						}
					}
				} 
			}
		}
		return $data;			
	}	
	//FIN FUNCION RECURSIVA





	//INICIO DEL ALGORITMO	
	$sql = "SELECT
			   ta_unidad_activa.id_unidad
			  ,ta_unidad_activa.nombre_unidad_activa
			  ,ta_unidad_padre.id_unidad_depende 
			FROM
			  ta_unidad_activa, ta_unidad 
			  LEFT JOIN ta_unidad_padre ON ta_unidad.id_unidad = ta_unidad_padre.id_unidad
			WHERE 
			  ta_unidad_padre.id_unidad IS NULL
			  AND (ta_unidad.ID_UNIDAD = ta_unidad_activa.id_unidad AND ta_unidad_activa.estado_unidad_activa = 1)";
	//echo $sql;
	//exit; 

	$Result = mysqli_query($conexion,$sql);
	
	if($Result){
		if(mysqli_num_rows($Result)>0){
			while($row = mysqli_fetch_object($Result)){
				$jsondata = recursivo($row->id_unidad, $jsondata, NULL);
			}
		}
	}

	echo json_encode($jsondata);
	exit;
	
?>