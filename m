Return-Path: <fixed-term.Thomas.Seeh@de.bosch.com>
Received: from imta2.fe.bosch.de (imta2.fe.bosch.de [139.15.238.165])
	by ozlabs.org (Postfix) with ESMTP id F4061B70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Oct 2009 00:05:13 +1100 (EST)
Received: from smtp2-v.fe.bosch.de (smtp2-v.fe.bosch.de [139.15.237.6])
	by imta2.fe.bosch.de (Postfix) with ESMTP id 4E12730065
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Oct 2009 14:57:54 +0200 (CEST)
Received: from vsmta3.fe.internet.bosch.com (unknown [10.4.98.30])
	by imta6.fe.bosch.de (Postfix) with ESMTP id AACDF370092
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Oct 2009 14:57:50 +0200 (CEST)
Received: from fe-imc01.de.bosch.com (vsgw4.fe.internet.bosch.com [10.4.98.12])
	by vsmta3.fe.internet.bosch.com (Postfix) with ESMTP id 812AB1580B2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Oct 2009 14:57:50 +0200 (CEST)
From: "FIXED-TERM Seeh Thomas (BEG/EMS1)" <fixed-term.Thomas.Seeh@de.bosch.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 14 Oct 2009 14:57:47 +0200
Subject: MPC5200B and USB
Message-ID: <6E9D235B18CE694399D781F05D9C42E7A035ADDD@SI-MBX11.de.bosch.com>
Content-Type: multipart/alternative;
	boundary="_000_6E9D235B18CE694399D781F05D9C42E7A035ADDDSIMBX11deboschc_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_6E9D235B18CE694399D781F05D9C42E7A035ADDDSIMBX11deboschc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

I'm working on a project to get USB ready on a MPC5200B based board.
On this board I'm not using Linux (but MQX), but my question is not related=
 to Linux.
It's more specific to USB and OHCI.
I will communicate with a Mass Storage Device and therefor the control tran=
sfer works fine.
The Mass Storage Device has two endpoints for bulk transfer, one IN (from d=
evice to host) and
one OUT (from host to device).

If I want to communicate with the device should I have two endpoints on the=
 host side too?
This would mean one endpoint which is associated with the IN endpoint to th=
e device and one endpoint which
is associated with OUT endpoint to the device. Is that right?
For example I want to send a INQUIRY command to the device. Which endpoint =
must I use
to send the command and on which endpoint do I receive the question?

Best regards

Thomas




--_000_6E9D235B18CE694399D781F05D9C42E7A035ADDDSIMBX11deboschc_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Arial, sans-serif" size=3D"2">
<div>Hello everyone,</div>
<div>&nbsp;</div>
<div>I'm working on a project to get USB ready on a MPC5200B based board.</=
div>
<div>On this board I'm not using Linux (but MQX), but my question is not re=
lated to Linux.</div>
<div>It's more specific to USB and OHCI.</div>
<div>I will communicate with a Mass Storage Device and therefor the control=
 transfer works fine.</div>
<div>The Mass Storage Device has two endpoints for bulk transfer, one IN (f=
rom device to host) and</div>
<div>one OUT (from host to device).</div>
<div>&nbsp;</div>
<div>If I want to communicate with the device should I have two endpoints o=
n the host side too?</div>
<div>This would mean one endpoint which is associated with the IN endpoint =
to the device and one endpoint which </div>
<div>is associated with OUT endpoint to the device. Is that right?</div>
<div>For example I want to send a INQUIRY command to the device. Which endp=
oint must I use</div>
<div>to send the command and on which endpoint do I receive the question?</=
div>
<div>&nbsp;</div>
<div>Best regards </div>
<div>&nbsp;</div>
<div><b>Thomas </b></div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
</font>
</body>
</html>

--_000_6E9D235B18CE694399D781F05D9C42E7A035ADDDSIMBX11deboschc_--
