Return-Path: <bharathik@icommtele.com>
Received: from blroutbound2.logix.in (blroutbound2.logix.in [115.112.214.38])
 by ozlabs.org (Postfix) with ESMTP id 75F892C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 18:37:52 +1000 (EST)
Received: from vdvmphy20-out.logix.in (127.0.0.1) by blroutbound2.logix.in
 (PowerMTA(TM) v3.5r11) id hu3hu01g654l for <linuxppc-dev@lists.ozlabs.org>;
 Thu, 25 Jul 2013 13:57:43 +0530 (envelope-from <bharathik@icommtele.com>)
Received: from unknown (HELO delta.logix.in) ([192.168.8.24])
 (envelope-sender <bharathik@icommtele.com>)
 by 192.168.8.51 (qmail-ldap-1.03) with SMTP
 for <linuxppc-dev@lists.ozlabs.org>; 25 Jul 2013 08:27:42 -0000
From: BHARATHI KANDIMALLA <bharathik@icommtele.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: P1021rdb-pc 
Date: Thu, 25 Jul 2013 08:29:45 +0000
Message-ID: <633176325F8AEB44967E1E3F9795BB22440FFEC9@TC-MX1.icommtele.local>
Content-Type: multipart/alternative;
 boundary="_000_633176325F8AEB44967E1E3F9795BB22440FFEC9TCMX1icommtelel_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_633176325F8AEB44967E1E3F9795BB22440FFEC9TCMX1icommtelel_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Dear Sir,

We  are using  P1021rdb-pc   board  with p1021 processor.

1.  compilation and build process  is taking  so  much of time. How should =
I
reduce the time for linux  build process?

2.  In  kernel configuration  we are not able to select  P1021rdb., When we=
 configured the  board for p1021RDB-PC ,  in  default kenel config  file   =
all the below platforms are selected , We want only  p1021rdb  , what shoul=
d we select here?

 CONFIG_PPC_CELL is not set
CONFIG_FSL_SOC_BOOKE=3Dy
CONFIG_FSL_85XX_CACHE_SRAM=3Dy
CONFIG_MPC8540_ADS=3Dy
CONFIG_MPC8560_ADS=3Dy
CONFIG_MPC85xx_CDS=3Dy
CONFIG_MPC85xx_MDS=3Dy
CONFIG_MPC8536_DS=3Dy
CONFIG_MPC85xx_DS=3Dy
CONFIG_MPC85xx_RDB=3Dy
# CONFIG_P1010_RDB is not set
CONFIG_P1022_DS=3Dy
CONFIG_P1023_RDS=3Dy
CONFIG_SOCRATES=3Dy
CONFIG_KSI8560=3Dy
CONFIG_XES_MPC85xx=3Dy
CONFIG_STX_GP3=3Dy
CONFIG_TQM8540=3Dy
CONFIG_TQM8541=3Dy
CONFIG_TQM8548=3Dy
CONFIG_TQM8555=3Dy
CONFIG_TQM8560=3Dy
CONFIG_SBC8548=3Dy

I am attaching  .config  file  for the reference


3. We are using  p1021 processor which has 36 bit support  , but we  have c=
ompiled uboot for 32 bit only.Is there any specfic use of 36 bit  compilati=
on, ?

only large amount of memory size 0f 64G, any way we are using only 512Mbyte=
 of  DDR, 128MBYte  NOR FLASH



4. Now we are using  SDK 1.3.2  for  p1021 procesor .Is there any specific
necessity that we should switch  to sdk1.4
regarding linux drivers  specially included for  p1021 procesor?

5.UMCC driver  is  available in  linux driver ? where should I get some hel=
p regarding UMCC ?


regards
Bharathi kandimalla


P.S. - Please Note our New Corporate office Address:-

ICOMM House,


Plot No.31, Kamalapuri,


Srinagar Colony, Banjara Hills,


Hyderabad - 500073, INDIA.


Disclaimer

This email is confidential. If you are not the addressee tell the sender im=
mediately and destroy this email without using, sending or storing it. E-ma=
il transmission cannot be secure as information could be intercepted, corru=
pted, lost, destroyed, delay, interception, amendment or incomplete, or con=
tain viruses. ICOMM TELE LTD and subsidiaries ("ICOMM") do not accept liabi=
lity for damage caused by this email and may monitor email traffic. Unless =
expressly stated, any opinions are the sender's and are not approved by ICO=
MM and this email is not an offer, solicitation, recommendation or agreemen=
t of any kind. If verification is required please request a hard-copy versi=
on. ICOMM's corporate office is ICOMM House, Plot No.31, Kamalapuri, Srinag=
ar Colony, Banjara Hills, Hyderabad - 500073 INDIA. Ph. No. : +91-40-2355-2=
222. Fax. No. : +91-40-2355-2266.

Thank You


ICOMM<http://www.icommtele.com>


--_000_633176325F8AEB44967E1E3F9795BB22440FFEC9TCMX1icommtelel_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html dir=3D"ltr">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style id=3D"owaParaStyle" type=3D"text/css">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
</head>
<body>
<div style=3D"direction:ltr; font-family:Tahoma; color:#000000; font-size:1=
0pt">Dear Sir,<br>
<br>
We&nbsp; are using&nbsp; P1021rdb-pc&nbsp;&nbsp; board&nbsp; with p1021 pro=
cessor.<br>
<br>
1.&nbsp; compilation and build process&nbsp; is taking&nbsp; so&nbsp; much =
of time. How should I&nbsp; <br>
reduce the time for linux&nbsp; build process?<br>
<br>
2.&nbsp; In&nbsp; kernel configuration&nbsp; we are not able to select&nbsp=
; P1021rdb., When we configured the&nbsp; board for p1021RDB-PC ,&nbsp; in&=
nbsp; default kenel config&nbsp; file&nbsp;&nbsp; all the below platforms a=
re selected , We want only&nbsp; p1021rdb&nbsp; , what should we select her=
e?<br>
<br>
&nbsp;CONFIG_PPC_CELL is not set<br>
CONFIG_FSL_SOC_BOOKE=3Dy<br>
CONFIG_FSL_85XX_CACHE_SRAM=3Dy<br>
CONFIG_MPC8540_ADS=3Dy<br>
CONFIG_MPC8560_ADS=3Dy<br>
CONFIG_MPC85xx_CDS=3Dy<br>
CONFIG_MPC85xx_MDS=3Dy<br>
CONFIG_MPC8536_DS=3Dy<br>
CONFIG_MPC85xx_DS=3Dy<br>
CONFIG_MPC85xx_RDB=3Dy<br>
# CONFIG_P1010_RDB is not set<br>
CONFIG_P1022_DS=3Dy<br>
CONFIG_P1023_RDS=3Dy<br>
CONFIG_SOCRATES=3Dy<br>
CONFIG_KSI8560=3Dy<br>
CONFIG_XES_MPC85xx=3Dy<br>
CONFIG_STX_GP3=3Dy<br>
CONFIG_TQM8540=3Dy<br>
CONFIG_TQM8541=3Dy<br>
CONFIG_TQM8548=3Dy<br>
CONFIG_TQM8555=3Dy<br>
CONFIG_TQM8560=3Dy<br>
CONFIG_SBC8548=3Dy<br>
<br>
I am attaching&nbsp; .config&nbsp; file&nbsp; for the reference<br>
<br>
<br>
3. We are using&nbsp; p1021 processor which has 36 bit support&nbsp; , but =
we&nbsp; have compiled uboot for 32 bit only.Is there any specfic use of 36=
 bit&nbsp; compilation, ?<br>
<br>
only large amount of memory size 0f 64G, any way we are using only 512Mbyte=
 of&nbsp; DDR, 128MBYte&nbsp; NOR FLASH
<br>
<br>
<br>
<br>
4. Now we are using&nbsp; SDK 1.3.2&nbsp; for&nbsp; p1021 procesor .Is ther=
e any specific <br>
necessity that we should switch&nbsp; to sdk1.4<br>
regarding linux drivers&nbsp; specially included for&nbsp; p1021 procesor?<=
br>
<br>
5.UMCC driver&nbsp; is&nbsp; available in&nbsp; linux driver ? where should=
 I get some help regarding UMCC ?<br>
<br>
<br>
regards <br>
Bharathi kandimalla<br>
</div>
<div style=3D"font-size:10pt; font-family:'Calibri',sans-serif">&nbsp;<br>
<div style=3D"background-color:#D5EAFF; border:1px dotted #003333; padding:=
.8em">
<p style=3D"font-weight:bold; color:#3300CC; font-size:11pt; line-height:10=
pt; font-family:'Cambria','times roman',serif">
P.S. - Please Note our New Corporate office Address:- </p>
<pre style=3D"font-weight:bold; color:#3300CC; font-size:10pt; line-height:=
0pt; font-family:'Calibri','times roman',serif">ICOMM House,
</pre>
<pre style=3D"font-size:10pt; line-height:0pt; font-family:'Calibri','times=
 roman',serif">Plot No.31, Kamalapuri,
</pre>
<pre style=3D"font-size:10pt; line-height:0pt; font-family:'Calibri','times=
 roman',serif">Srinagar Colony, Banjara Hills,
</pre>
<pre style=3D"font-size:10pt; line-height:0pt; font-family:'Calibri','times=
 roman',serif">Hyderabad &#8211; 500073, INDIA.
</pre>
<p span=3D"" style=3D"font-size:12pt; font-family:'Calibri','times new roma=
n','garamond',serif; color:#ff0000">
Disclaimer</p>
<p style=3D"font-size:9pt; line-height:11pt; font-family:'Calibri','times r=
oman',serif">
This email is confidential. If you are not the addressee tell the sender im=
mediately and destroy this email without using, sending or storing it. E-ma=
il transmission cannot be secure as information could be intercepted, corru=
pted, lost, destroyed, delay, interception,
 amendment or incomplete, or contain viruses. ICOMM TELE LTD and subsidiari=
es (&quot;ICOMM&quot;) do not accept liability for damage caused by this em=
ail and may monitor email traffic. Unless expressly stated, any opinions ar=
e the sender's and are not approved by ICOMM
 and this email is not an offer, solicitation, recommendation or agreement =
of any kind. If verification is required please request a hard-copy version=
. ICOMM's corporate office is ICOMM House, Plot No.31, Kamalapuri, Srinagar=
 Colony, Banjara Hills, Hyderabad
 - 500073 INDIA. Ph. No. : &#43;91-40-2355-2222. Fax. No. : &#43;91-40-2355=
-2266. </p>
<pre style=3D"font-size:10pt; line-height:11pt; font-family:'Calibri','time=
s roman',serif">Thank You
</pre>
<span style=3D"padding-top:10px; font-weight:bold; color:#CC0000; font-size=
:10pt; font-family:'Calibri',Arial,sans-serif"><a href=3D"http://www.icommt=
ele.com">ICOMM</a></span><br>
<br>
</div>
</div>
</body>
</html>

--_000_633176325F8AEB44967E1E3F9795BB22440FFEC9TCMX1icommtelel_--
