<%@page import="Dao.MedicamentosDAO"%>
<%@page import="modelo.Medicamentos"%>
<%@page import="util.StormData"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>


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


    
     if(request.getMethod().equals("POST")){

    if (request.getParameter("txtMedNome") != null) {
        obj.setMedcod(Integer.parseInt(request.getParameter("txtMedCodigo")));
        obj.setMednome(request.getParameter("txtMedNome"));
        obj.setMedbula(request.getParameter("txtMedBula"));
        obj.setMedqtdade(Double.parseDouble(request.getParameter("txtMedQuantidade")));
        obj.setMedfoto(request.getParameter("txtMedFoto"));
        
        p.setPostocod(Integer.parseInt(request.getParameter("txtPostoNome")));
        obj.setPostocod(p);

        Boolean resultado = meddao.incluir(obj);

        if (resultado) {
            msg = "Registro cadastrado com sucesso";
            classe = "alert-success";
        } else {
            msg = "N�o foi poss�vel cadastrar";
            classe = "alert-danger";
        }
        
         String redirectURL = "medlistagem.jsp";
        response.sendRedirect(redirectURL);
     
    } 
    
         meddao.fecharConexao();
        }
     
%>



  <body>

  <section id="container" >
      <!--CABE�ALHO-->
        
      <section id="main-content">
          <section class="wrapper">
          	<h3><i class="fa fa-angle-right"></i> Cadastro - Medicamentos</h3>
                
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
                                  <input type="text"  name="txtMedCodigo" class="form-control">
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Nome</label>
                              <div class="col-sm-10">
                                  <input type="text" name="txtMedNome" class="form-control">
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Quantidade</label>
                              <div class="col-sm-10">
                                  <input type="text" name="txtMedQuantidade" class="form-control">
                              </div>
                          </div>
                        
                                     
                             <div class="form-group">
                             <label class="col-sm-2 col-sm-2 control-label">Posto</label>
                             <div class="col-sm-10">

                                 <select id="inputPosto" name="txtPostoNome" type="text" class="form-control" required placeholder="Selecione">
                                  
                                         <%
                                             for (Posto itemp : plistar) {
                                         %>
                                     <option value = "<%=itemp.getPostocod()%>">
                                         <%=itemp.getPostonome()%>
                                     </option>
                                     <%
                                         }
                                     %>
                                 
                                 </select>
                             </div>        

                          <div class="form-group">
                                <label class="col-sm-2 col-sm-2 control-label">Bula</label>
                                    <div class="col-sm-10">
                                        <textarea  name="txtMedBula" id="message" class="form-control " cols="30" rows="8">
                                        </textarea>
                                    </div>
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
                        <input type="submit" class="btn btn-primary btn-lg btn-block" value="Cadastrar">
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

  <script>
      //custom select box

      $(function(){
          $('select.styled').customSelect();
      });

  </script>

  </body>
</html>
