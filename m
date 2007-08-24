Return-Path: <joachim.bader@diehl-aerospace.de>
Received: from mail02.diehl.de (mail02.diehl.de [193.201.236.151])
	by ozlabs.org (Postfix) with ESMTP id 771EDDDE22
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Aug 2007 00:02:00 +1000 (EST)
Received: from alg2.diehl.com (localhost [127.0.0.1])
	by alg2.diehl.com (8.13.8/8.13.8) with ESMTP id l7ODpmtI014791
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Aug 2007 15:51:48 +0200 (CEST)
To: linuxppc-embedded@ozlabs.org
Subject: [linux kernel 2.6.19] ethernet driver for Marvell bridge GT-64260
MIME-Version: 1.0
From: joachim.bader@diehl-aerospace.de
Message-ID: <OF2C2E8C6F.3860730F-ONC1257341.004B3D4B-C1257341.004C2882@diehl-gruppe.de>
Date: Fri, 24 Aug 2007 15:51:33 +0200
Content-Type: multipart/alternative;
	boundary="=_alternative 004C2881C1257341_="
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dies ist eine mehrteilige Nachricht im MIME-Format.
--=_alternative 004C2881C1257341_=
Content-Type: text/plain; charset="utf-8"
content-transfer-encoding: quoted-printable

Hello everybody,

I continue the work of ThomasB to get a linux kernel 2.6.19 up and running=
=20
on a PPC750FX based platform using a GT-64260.
From=20Thomas I got a patched mv643xx_eth driver which is ported to support=
=20
the 64260, too.
Now the driver is integrated and runs complete through initialisation=20
bringing up an eth0 device.
The initialisation seams to be ok (no error messages), the device is up=20
and routing information is setup.
Now I try to ping a remote station but I receive nothing and I get no=20
feedback from the remote compter.
As soon as I turn of the net interface (ifconfig eth0 down) I get the=20
message "Tx time out or no link?)
Is there anything else I can check? Any idea what may cause this problem?

Thanks a lot for your help

Joachim



___________________________________________________________________________=
____________________________________________
Der Inhalt dieser E-Mail ist f=C3=BCr den Absender rechtlich nicht verbindl=
ich.=20
Informieren Sie uns bitte, wenn Sie diese E-Mail f=C3=A4lschlicherweise erh=
alten haben (Fax: +49-69-5805-1399). Bitte l=C3=B6schen Sie in diesem Fall =
die Nachricht. Jede Form der weiteren Benutzung ist untersagt.

The content of this e-mail is not legally binding upon the sender.
If this e-mail was transmitted to you by error, then please inform us accor=
dingly (Fax: +49-69-5805-1399). In such case you are requested to erase the=
 message. Any use of such e-mail message is strictly prohibited.

--=_alternative 004C2881C1257341_=
Content-Type: text/html; charset="utf-8"
content-transfer-encoding: quoted-printable


<br><font size=3D2 face=3D"sans-serif">Hello everybody,</font>
<br>
<br><font size=3D2 face=3D"sans-serif">I continue the work of ThomasB to get
a linux kernel 2.6.19 up and running on a PPC750FX based platform using
a GT-64260.</font>
<br><font size=3D2 face=3D"sans-serif">From Thomas I got a patched mv643xx_=
eth
driver which is ported to support the 64260, too.</font>
<br><font size=3D2 face=3D"sans-serif">Now the driver is integrated and runs
complete through initialisation bringing up an eth0 device.</font>
<br><font size=3D2 face=3D"sans-serif">The initialisation seams to be ok (no
error messages), the device is up and routing information is setup.</font>
<br><font size=3D2 face=3D"sans-serif">Now I try to ping a remote station b=
ut
I receive nothing and I get no feedback from the remote compter.</font>
<br><font size=3D2 face=3D"sans-serif">As soon as I turn of the net interfa=
ce
(ifconfig eth0 down) I get the message &quot;Tx time out or no link?)</font>
<br><font size=3D2 face=3D"sans-serif">Is there anything else I can check?
Any idea what may cause this problem?</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Thanks a lot for your help</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Joachim</font>
<br>
<br>
<br>
<span style=3D"font-family:sans-serif,helvetica; font-size:10pt; color:#000=
000">______________________________________________________________________=
_________________________________________________</span><br>
<span style=3D"font-family:sans-serif,helvetica; font-size:10pt; color:#000=
000">Der Inhalt dieser E-Mail ist f=C3=BCr den Absender rechtlich nicht ver=
bindlich. </span><br>
<span style=3D"font-family:sans-serif,helvetica; font-size:10pt; color:#000=
000">Informieren Sie uns bitte, wenn Sie diese E-Mail f=C3=A4lschlicherweis=
e erhalten haben (Fax: +49-69-5805-1399). Bitte l=C3=B6schen Sie in diesem =
Fall die Nachricht. Jede Form der weiteren Benutzung ist untersagt.</span><=
br>
<br>
<span style=3D"font-family:sans-serif,helvetica; font-size:10pt; color:#000=
000">The content of this e-mail is not legally binding upon the sender.</sp=
an><br>
<span style=3D"font-family:sans-serif,helvetica; font-size:10pt; color:#000=
000">If this e-mail was transmitted to you by error, then please inform us =
accordingly (Fax: +49-69-5805-1399). In such case you are requested to eras=
e the message. Any use of such e-mail message is strictly prohibited.</span=
><br>
<br>
--=_alternative 004C2881C1257341_=--
