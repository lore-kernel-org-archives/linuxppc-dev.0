Return-Path: <joachim.bader@diehl-aerospace.de>
Received: from mail02.diehl.de (mail02.diehl.de [193.201.236.151])
	by ozlabs.org (Postfix) with ESMTP id D09DFDDEF7
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Sep 2007 01:58:10 +1000 (EST)
Received: from alg2.diehl.com (localhost [127.0.0.1])
	by alg2.diehl.com (8.13.8/8.13.8) with ESMTP id l7VFw80t023485
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 31 Aug 2007 17:58:08 +0200 (CEST)
To: linuxppc-embedded@ozlabs.org
Subject: [linux kernel 2.6.19] ethernet driver for Marvell bridge GT-64260
MIME-Version: 1.0
From: joachim.bader@diehl-aerospace.de
Message-ID: <OF71BAC825.59CE0529-ONC1257348.0056D44E-C1257348.0057BBA0@diehl-gruppe.de>
Date: Fri, 31 Aug 2007 17:58:01 +0200
Content-Type: multipart/alternative;
	boundary="=_alternative 0057BB9EC1257348_="
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
--=_alternative 0057BB9EC1257348_=
Content-Type: text/plain; charset="utf-8"
content-transfer-encoding: quoted-printable

Hello,

I am porting linux kernel 2.6.19 on a platform based on PPC750FX together=20
with a Marvell GT64260.
I use a patched 643xx driver which is back ported to 64260 by Steven J.=20
Hill.
I have ethernet now up and running, but only if I switch debug on, which=20
generates a big bunch of screen messages.
As soon as I switch debug off, I get the message "Virtual device %s asks=20
to queue packet!" on every transmission request.

This happens on ping an other system.

Has anyone experience in such an event? Is there anything how I can speed=20
up performance with the 64260?
Is there a similar problem known with the 64360?

Thanks in advance.
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

--=_alternative 0057BB9EC1257348_=
Content-Type: text/html; charset="utf-8"
content-transfer-encoding: quoted-printable


<br><font size=3D2 face=3D"sans-serif">Hello,</font>
<br>
<br><font size=3D2 face=3D"sans-serif">I am porting linux kernel 2.6.19 on
a platform based on PPC750FX together with a Marvell GT64260.</font>
<br><font size=3D2 face=3D"sans-serif">I use a patched 643xx driver which is
back ported to 64260 by Steven J. Hill.</font>
<br><font size=3D2 face=3D"sans-serif">I have ethernet now up and running,
but only if I switch debug on, which generates a big bunch of screen messag=
es.</font>
<br><font size=3D2 face=3D"sans-serif">As soon as I switch debug off, I get
the message &quot;Virtual device %s asks to queue packet!&quot; on every
transmission request.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">This happens on ping an other system=
.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Has anyone experience in such an eve=
nt?
Is there anything how I can speed up performance with the 64260?</font>
<br><font size=3D2 face=3D"sans-serif">Is there a similar problem known with
the 64360?</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Thanks in advance.</font>
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
--=_alternative 0057BB9EC1257348_=--
