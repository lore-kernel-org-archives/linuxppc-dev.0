Return-Path: <d.bosi@selcomgroup.com>
Received: from xseries02.selcomgroup.com (mail.selcomgroup.com [85.18.34.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 04737DDF66
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Aug 2008 20:58:01 +1000 (EST)
Received: from [172.26.3.53] ([172.26.3.53]) (authenticated bits=0)
	by xseries02.selcomgroup.com (8.13.4/8.13.4) with ESMTP id
	m7PAXAhn025484
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Aug 2008 12:33:11 +0200
Message-ID: <48B28A65.2050409@selcomgroup.com>
Date: Mon, 25 Aug 2008 12:33:09 +0200
From: Daniele Bosi <d.bosi@selcomgroup.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: gdb problems with threads on mpc512x
Content-Type: text/html; charset=ISO-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body bgcolor="#ffffff" text="#000000">
I encountered several problem debugging multithreated software with gdb
on mpc512x, remotely (gdbserver) and locally.<br>
I built gdb 6.8 from scratch, but it's crashing when I stop execution
into a thread.<br>
<br>
Did anyone get it to work correctly?<br>
<br>
Thanks,<br>
Daniele<br>
<br>
<div class="moz-signature">-- <br>
<div class="Section1"><br>
<br>
<hr>
<h1><span style="font-size: 10pt;">Daniele Bosi<o:p></o:p></span></h1>
<p class="MsoNormal"><b><span
 style="font-size: 10pt; font-family: Verdana;">DIGITEK S.p.A.</span></b></p>
<p class="MsoNormal"><span style="font-size: 7pt; font-family: Verdana;">Via
L. Romagnoli 24, <br>
41033 Concordia sulla Secchia <br>
Modena (MO), Italy<o:p></o:p></span></p>
<p class="MsoNormal"><b><span
 style="font-size: 7pt; font-family: Verdana;" lang="EN-GB">Tel</span></b><span
 style="font-size: 7pt; font-family: Verdana;" lang="EN-GB">:
+39-(0)53556942 Fax. +39-(0)53554550<o:p></o:p></span></p>
<p class="MsoNormal"><b><span
 style="font-size: 7pt; font-family: Verdana;" lang="EN-GB">Web:<span
 style="">    </span></span></b><span
 style="font-size: 7pt; font-family: Verdana;" lang="EN-GB"><span
 style=""> </span></span><span
 style="font-size: 7pt; font-family: Verdana;"><a
 href="http://www.digitek.it"><span style="" lang="EN-GB">http://www.digitek.it</span></a></span><span
 style="font-size: 7pt; font-family: Verdana;" lang="EN-GB"><o:p></o:p></span></p>
<!--<p class=MsoNormal><b><span lang=EN-GB style='font-size:7.0pt;mso-bidi-font-size:
		15.0pt;font-family:Verdana;mso-ansi-language:EN-GB'>Mail to:</span></b><span
		lang=EN-GB style='font-size:7.0pt;mso-bidi-font-size:15.0pt;font-family:Verdana;
		mso-ansi-language:EN-GB'> </span><span style='font-size:7.0pt;mso-bidi-font-size:
		15.0pt;font-family:Verdana'><a href="mailto:danielebosi@digitek.it"><span
		lang=EN-GB style='mso-ansi-language:EN-GB'>danielebosi@digitek.it</span></a></span><span
		lang=EN-GB style='font-size:7.0pt;mso-bidi-font-size:12.0pt;mso-ansi-language:
		EN-GB'><o:p></o:p></span></p>-->
<p class="MsoNormal"><b><span
 style="font-size: 7pt; font-family: Verdana;" lang="EN-GB">Mail to:</span></b><span
 style="font-size: 7pt; font-family: Verdana;" lang="EN-GB"> </span><span
 style="font-size: 7pt; font-family: Verdana;"><a
 href="mailto:d.bosi@selcomgroup.com"><span style="" lang="EN-GB">d.bosi@selcomgroup.com</span></a></span><span
 style="font-size: 7pt;" lang="EN-GB"><o:p></o:p></span></p>
</div>
</div>
</body>
</html>
