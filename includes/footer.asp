		<aside class="visible-sm visible-xs hidden-print" id="bottomPartners" aria-label="JWCRP partners">
			<hr />
			<p class="noBottomMargin"><strong>Our partners:</strong></p>
			<a href="https://www.bas.ac.uk/"><img src="/images/bas-logo.png" alt="British Antarctic Survey" title="go to the BAS website" class="fad img-responsive" /></a>
			<a href="https://www.ceh.ac.uk/"><img src="/images/ceh-logo.png" alt="Centre for Ecology and Hydrology" title="go to the CEH website" class="fad img-responsive" /></a>	
			<a href="https://www.ncas.ac.uk/"><img src="/images/ncas-logo.png" alt="National Centre for Atmospheric Science" title="go to the NCAS website" class="fad img-responsive" /></a>
			<a href="https://www.nceo.ac.uk/"><img src="/images/nceo-logo.png" alt="National Centre for Earth Observation" title="go to the NCEO website" class="fad img-responsive" /></a>
			<a href="http://noc.ac.uk/"><img src="/images/noc-logo.png" alt="National Oceanography Centre" title="go to the NOC website" class="fad img-responsive" /></a>
			<a href="http://www.pml.ac.uk/"><img src="/images/pml-logo.png" alt="Plymouth Marine Laboratory" title="go to the PML website" class="fad img-responsive" /></a>					
		</aside>
	</div>
	
	<footer>
		<div class="hidden-print container">
			<div class="row" id="footer">
				<div class="col-sm-6">
					<div class="footerCell">
						<a href="http://www.metoffice.gov.uk/about-us/legal/tandc#Use-of-Crown-Copyright" title="external link">&copy; Crown copyright <%=year(now)%></a> &nbsp;|&nbsp; <a href="/sitemap.asp" accesskey="3">Sitemap</a>
					</div>
				</div>
				
				<div class="col-sm-6">
					<div class="text-right footerCell">
						Last updated: <%= FileLastMod %>
					</div>
				</div>	
			</div>
		</div>
	</footer>
	
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
	<script src="/js/bootstrap.min.js"></script>
	<script>
	$('#partners').css('visibility', 'hidden');
	$('.fad2').hide();
	$('#partners').css('visibility', 'visible');
	$('#bottomPartners').css('visibility', 'hidden');
	$('.fad').hide();
	$('#bottomPartners').css('visibility', 'visible');

	$(document).ready(function(){
		var bodyHeight = $("#short").height();
		var viewPortSize = $(window).height();
		var triggerAbove = 130;
		var triggerHeight = (bodyHeight - viewPortSize) - triggerAbove;
		var fadeDone = 0;
		if (triggerHeight <= 0) {
			fadeDone = 1;
			for (i = 0; i < 6; i++) {
				if (i == 0) {
					$('.fad:eq(' + i + ')').fadeIn(1000);
				} else {
					$('.fad:eq(' + i + ')').delay(200 * i).fadeIn(1000);
				}
			}	
		}
		
		$(window).scroll(function () {
			console.log($(window).scrollTop());
			if (fadeDone == 0) {
				if ($(window).scrollTop() >= triggerHeight) {
					for (i = 0; i < 6; i++) {
						if (i == 0) {
							$('.fad:eq(' + i + ')').fadeIn(1000);
						} else {
							$('.fad:eq(' + i + ')').delay(200 * i).fadeIn(1000);
						}
					}
					$(this).off('scroll');
				}
			}
		});

		for (i = 0; i < 6; i++) {
			if (i == 0) {
				$('.fad2:eq(' + i + ')').fadeIn(1000);
			} else {
				$('.fad2:eq(' + i + ')').delay(200 * i).fadeIn(1000);
			}
		}	
		
	});
	</script>
	<!-- Website design by Sean Terry @ NERC -->
</body>
</html>