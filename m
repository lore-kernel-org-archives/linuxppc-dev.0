Return-Path: <f.savane@caramail.com>
Received: from lmfilto02.st1.spray.net (lmfilto02.st1.spray.net
	[212.78.202.66]) by ozlabs.org (Postfix) with ESMTP id 0CF1D67A6D
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Mar 2005 21:44:44 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lmfilto02.st1.spray.net (Postfix) with ESMTP id 00760123D8D
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Mar 2005 10:26:34 +0000 (GMT)
Received: from cmcodec02.st1.spray.net ([212.78.202.183])
	by localhost (lmfilto02.st1.spray.net [212.78.202.32]) (amavisd-new,
	port 10024)
	with ESMTP id 24005-05 for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Mar 2005 10:26:33 +0000 (GMT)
Received: from cmcodec02.st1.spray.net (localhost [127.0.0.1])
	by cmcodec02.st1.spray.net (Postfix) with SMTP id AA2C582D00
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Mar 2005 10:26:33 +0000 (GMT)
From: "=?windows-1252?Q?Fr=E9d=E9ric=20Savane?=" <f.savane@caramail.com>
To: linuxppc-embedded@ozlabs.org
Message-ID: <1111400793011690@lycos-europe.com>
Mime-Version: 1.0
Date: Mon, 21 Mar 2005 10:26:33 GMT 
Content-Type: multipart/mixed; boundary="=_NextPart_Lycos_0116901111400793_ID"
Subject: DS1306 RTC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

--=_NextPart_Lycos_0116901111400793_ID
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: 7bit

<html><head><style type="text/css">body{font:12px Arial;margin:3px;overflow-y:auto;overflow-x:auto}p{margin:0px;}blockquote, ol, ul{margin-top:0px;margin-bottom:0px;}</style></head>

<body><div style="DISPLAY: block; FONT-SIZE: 12px; FONT-FAMILY: Arial"><P>Hello !</P>
<P>&nbsp;</P>
<P>I saw you had a programm for the ds1306 do you have it for initialize read and write the RTC ?</P>
<P>I use a pifc8f458 and a ds1306, and i want to have a RTC with ccs compiler.</P>
<P>&nbsp;</P>
<P>Please send me your programm.</P>
<P>&nbsp;</P>
<P>Best regards.</P>
<P>&nbsp;</P>
<P>Many thanks</P>
<P>Hi<BR><BR>Personnaly I use a DS1306 on SPI to do RTC on a<BR>MPC860.<BR>I don't use it under linux still now. But succesfully<BR>run it under RTOS.<BR><BR>It's port under U-Boot so it's should not be difficult<BR>to<BR>use it under linux. If someone have some more<BR>information<BR>about DS1306 under linux (or throught U-Boot may be).<BR><BR>If you want to look at the DS1306 U-Boot driver, look<BR>at<BR>		boot/u-boot/rtc/ds1306.c<BR><BR>Expects that help<BR><BR>Cedric<BR></P></br><p style="margin-top:11px;padding-top:3px;background-image: url(http://mail.lycos.co.uk/Images/Mail/_content/dot.gif);background-repeat: repeat-x;background-position: 0px 0px;"><img src="http://premiummail.caramail.lycos.fr/Images/Mail/_icons/premium.gif"><font color="#CC0000"><b> 300 Mo gratuits sur CaraMail : </b></font><a href="http://secure.caramail.lycos.fr/services/signin/mail.jsp?TARGETCODE=FR_footermail_link" target="_blank">Cliquez ici pour en profiter!</a></div></body></html>


--=_NextPart_Lycos_0116901111400793_ID--
