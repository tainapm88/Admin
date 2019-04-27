<%@page import="Dao.MedicamentosDAO"%>
<%@page import="modelo.Medicamentos"%>
<%@page import="util.StormData"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="modelo.Estado"%>
<%@page import="Dao.EstadoDAO"%>

<%@page import="modelo.Municipibge"%>
<%@page import="Dao.MunicipibgeDAO"%>

<%@page import="Dao.PostoDAO"%>
<%@page import="modelo.Posto"%>

<%@page import="java.util.List"%>
<%@include file="cabecalho.jsp" %>


<%
    String msg = "";
    String classe = "";
    
    Medicamentos obj = new Medicamentos();
    MedicamentosDAO meddao = new MedicamentosDAO();
    
    PostoDAO pdao = new PostoDAO();
    List<Posto> plistar = pdao.listar();
    Posto p = new Posto();

    EstadoDAO edao = new EstadoDAO();
    List<Estado> elistar = edao.listar();
    Estado e = new Estado();
    
    
    MunicipibgeDAO mdao = new MunicipibgeDAO();
    List<Municipibge> mlistar = mdao.listar();
    Municipibge m = new Municipibge();

    
     if(request.getMethod().equals("POST")){
        obj.setMedcod(Integer.parseInt(request.getParameter("txtMedCodigo")));
        obj.setMednome(request.getParameter("txtMedNome"));
        obj.setMedbula(request.getParameter("txtMedBula"));
        obj.setMedqtdade(Double.parseDouble(request.getParameter("txtMedQuantidade")));
        obj.setMedfoto(request.getParameter("txtMedFoto"));
        
        e = edao.buscarPorChavePrimaria(Long.parseLong(request.getParameter("txtEstadoNome")));
        m = mdao.buscarPorChavePrimaria(request.getParameter("txtCidadeNome"));
        p = pdao.buscarPorChavePrimaria(Integer.parseInt(request.getParameter("txtPostoNome")));
        obj.setId(e);
        obj.setMunicipibge(m);
        obj.setPostocod(p);
                  
        Boolean resultado = meddao.alterar(obj);
        
     
        if (resultado) {
            msg = "Registro cadastrado com sucesso";
            classe = "alert-success";
        } else {
            msg = "N�o foi poss�vel cadastrar";
            classe = "alert-danger";
        }
        
         } else {
        //e GET
        if (request.getParameter("codigo") == null) {
            response.sendRedirect("medlistagem.jsp");
            return;
        }

        meddao = new MedicamentosDAO();
        obj = meddao.buscarPorChavePrimaria(Integer.parseInt(request.getParameter("codigo")));

        if (obj == null) {
            response.sendRedirect("medlistagem.jsp");
            return;
        }
    }
     
   
     
%>


<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="Dashboard">
    <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">

    <title>Alterar - Medicamentos</title>

    <!-- Bootstrap core CSS -->
    <link href="assets/css/bootstrap.css" rel="stylesheet">
    <!--external css-->
    <link href="assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="assets/js/bootstrap-datepicker/css/datepicker.css" />
    <link rel="stylesheet" type="text/css" href="assets/js/bootstrap-daterangepicker/daterangepicker.css" />
        
    <!-- Custom styles for this template -->
    <link href="assets/css/style.css" rel="stylesheet">
    <link href="assets/css/style-responsive.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>

  <section id="container" >
      <%@include file="lado.jsp" %>
      <!--CABE�ALHO-->
        
      <section id="main-content">
          <section class="wrapper">
          	<h3><i class="fa fa-angle-right"></i> Alterar - Medicamentos</h3>
                
                <div class="alert <%=classe%>">
                <%=msg%>
            </div>
            <form action="../../UploadWS" method="post" enctype="multipart/form-data">
          	
          	<!-- BASIC FORM ELELEMNTS -->
          	<div class="row mt">
          		<div class="col-lg-12">
                  <div class="form-panel">
                  	  
                      
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">C�digo</label>
                              <div class="col-sm-10">
                                  <input type="text"  name="txtMedCodigo" class="form-control" readonly value="<%=obj.getMedcod()%>">
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Nome</label>
                              <div class="col-sm-10">
                                  <input type="text" name="txtMedNome" class="form-control" readonly value="<%=obj.getMednome()%>">
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Quantidade</label>
                              <div class="col-sm-10">
                                  <input type="text" name="txtMedQuantidade" class="form-control" required value="<%=obj.getMedqtdade()%>">
                              </div>
                          </div>
       

                          <div class="form-group">
                                <label class="col-sm-2 col-sm-2 control-label">Bula</label>
                                    <div class="col-sm-10">
                                        <textarea  name="txtMedBula" id="message" class="form-control " cols="30" rows="8" >
                                        </textarea>
                                    </div>
                          </div>
                              
                          <div class="form-group">
                            <label class="col-sm-2 col-sm-2 control-label">Estado</label>
                            <div class="col-sm-10">
                                
                            <select id="inputEstado" name="txtEstadoNome" class="form-control" reandoly value="<%=obj.getId()%>">
                                <option selected>
                                    <%
                           for (Estado iteme : elistar) {
                               String selecionado;
                               if(iteme.getId()== obj.getId().getId()){
                               selecionado = "selected";
                               
                               }else{
                                   selecionado= " ";
                               }
                         %>
                                <option <%=selecionado%> value = "<%=iteme.getId()%>">
                             <%=iteme.getNome()%>
                         </option>
                         <%
                             }
                         %>
                                </option>
                                
                            </select>
                         </div>
                                

                         <div class="form-group">
                             <label class="col-sm-2 col-sm-2 control-label">Cidade</label>
                             <div class="col-sm-10">

                                 <select id="inputCidade" name="txtCidadeNome"  class="form-control" reandoly value="<%=obj.getMunicipibge()%>">
                                     <option selected>
                                         <%
                                             for (Municipibge itemm : mlistar) {
                                        
                                         %>
                                     <option value = "<%=itemm.getMunicipibge()%>">
                                         <%=itemm.getMunicipnome()%>
                                     </option>
                                     <%
                                         }
                                     %>
                                     </option>
                                 </select>
                             </div>
                                     
                             <div class="form-group">
                             <label class="col-sm-2 col-sm-2 control-label">Posto</label>
                             <div class="col-sm-10">

                                 <select id="inputPosto" name="txtPostoNome"  class="form-control" reandoly value="<%=obj.getPostocod()%>">
                                     <option selected>
                                         <%
                                             for (Posto itemp : plistar) {
                                                 
                                         %>
                                     <option value = "<%=itemp.getPostocod()%>">
                                         <%=itemp.getPostonome()%>
                                     </option>
                                     <%
                                         }
                                     %>
                                     </option>
                                 </select>
                             </div>
                                     
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Foto</label>
                              <div class="col-sm-10">
                                  <div class="form-group">
                                    <input class="form-control" type="file"  name="txtMedFoto"  required />
                                  </div>

                              </div>
                      
                          </div>
          		</div><!-- col-lg-12-->   
                         
          	</div><!-- /row -->
                
                <div class="showback">
                        <input type="submit" class="btn btn-primary btn-lg btn-block" value="Alterar"></a>
                    </div><!--/showback -->
                      </form>
                
		</section><! --/wrapper -->
      </section><!-- /MAIN CONTENT -->

      <!--main content end-->
      <!--footer start-->
      <footer class="site-footer">
          <div class="text-center">
              2019 - Tain� Pacheco Morais
              <a href="form_component.html#" class="go-top">
                  <i class="fa fa-angle-up"></i>
              </a>
          </div>
      </footer>
      <!--footer end-->
  </section>

    <!-- js placed at the end of the document so the pages load faster -->
    <script src="assets/js/jquery.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script class="include" type="text/javascript" src="assets/js/jquery.dcjqaccordion.2.7.js"></script>
    <script src="assets/js/jquery.scrollTo.min.js"></script>
    <script src="assets/js/jquery.nicescroll.js" type="text/javascript"></script>


    <!--common script for all pages-->
    <script src="assets/js/common-scripts.js"></script>

    <!--script for this page-->
    <script src="assets/js/jquery-ui-1.9.2.custom.min.js"></script>

	<!--custom switch-->
	<script src="assets/js/bootstrap-switch.js"></script>
	
	<!--custom tagsinput-->
	<script src="assets/js/jquery.tagsinput.js"></script>
	
	<!--custom checkbox & radio-->
	
	<script type="text/javascript" src="assets/js/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
	<script type="text/javascript" src="assets/js/bootstrap-daterangepicker/date.js"></script>
	<script type="text/javascript" src="assets/js/bootstrap-daterangepicker/daterangepicker.js"></script>
	
	<script type="text/javascript" src="assets/js/bootstrap-inputmask/bootstrap-inputmask.min.js"></script>
	
	
	<script src="assets/js/form-component.js"></script>    
    
    
  <script>
      //custom select box

      $(function(){
          $('select.styled').customSelect();
      });

  </script>

  </body>
</html>
