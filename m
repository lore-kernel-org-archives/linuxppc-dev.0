Return-Path: <hbruegge@rockwellcollins.com>
Received: from vs01.rockwellcollins.com (ovs01.rockwellcollins.com
	[205.175.225.231])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail01.rockwellcollins.com",
	Issuer "Rockwell Collins Intermediate CA I" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7B56BDDF19
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Mar 2007 21:39:40 +1100 (EST)
Received: from vs01.rockwellcollins.com (localhost [127.0.0.1])
	by localhost.rockwellcollins.com (Postfix) with ESMTP id EBA393192C
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Mar 2007 04:20:30 -0600 (CST)
Received: from crnotes2.rockwellcollins.com (crnotes2.rockwellcollins.com
	[131.198.64.109])
	by vs01.rockwellcollins.com (Postfix) with ESMTP id C72A2318E5
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Mar 2007 04:20:30 -0600 (CST)
To: linuxppc-embedded@ozlabs.org
Subject: login on console=tty with serial input
MIME-Version: 1.0
Message-ID: <OF1C808DEE.C8EB82B2-ONC1257295.003752BA-C1257296.0038EEB2@rockwellcollins.com>
From: hbruegge@rockwellcollins.com
Date: Tue, 6 Mar 2007 11:21:51 +0100
Content-Type: multipart/alternative;
	boundary="=_alternative 0038EE7FC1257296_="
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
--=_alternative 0038EE7FC1257296_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi everyone.


I just wondering, if anyone outthere can help me. I am currently kind of=20
lost.

I have an embedded powerpc based system running with kernel 2.6.20.  The=20
system has only two serial lines and no PS/2 or USB support. Therefore I=20
control the system via a serial console ( passing the commandline arg:=20
console=3DttyS0,57600) and a terminal.
A getty program is running on /dev/console, which gives me a login:=20
prompt, so I can login via the serial line ttyS0.
All is working pretty perfect.

So far so good. And now here comes my problem.=20
To add a better MMI in the future I want to use the graphic card as an=20
output.

I added a  graphic card to the system. The kernel configuration includes=20
framebuffer support for that particular graphic card.=20
After booting the kernel, I can see a /dev/fb0 device and testing with=20
'echo "hello" > /dev/fb0', the message "hello" is displayed on the screen. =


Also if I add the commandline arg: console=3Dtty console=3DttyS0,57600 , I =
get=20
all kernel messages displayed, not only on the serial line, but also on=20
the screen via the framebuffer.

So basically, what I want is graphical output (dev/fb0) with serial input=20
(/dev/ttyS0). The user sees a login prompt on the screen and can enter=20
characters by a terminal program connected to the serial line.
Right to that point I always used the serial console for user interaction. =

By adding only the commandline argument console=3Dtty, I get a nice login=20
prompt on the graphic screen. BUT I have no input via the serial line???

So, how do I connect the serial line /dev/ttySx  to the standard input=20
path of the virtual console.

Any hint is welcomed. Any manuals to read are also welcomed.=20

Thanx

Harald Br=FCggemann

--------------------------------------------------------
Harald Br=FCggemann
Rockwell Collins Deutschland GmbH
Grenzh=F6ferWeg 36
D-69046 Heidelberg
Germany
=20
Phone:     +49 - 6221 - 512 484
Fax:          +49 - 6221 - 512 301
=20
e-mail:   hbruegge@rockwellcollins.com
--=_alternative 0038EE7FC1257296_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable


<br><font size=3D2 face=3D"sans-serif">Hi everyone.</font>
<br>
<br>
<br><font size=3D2 face=3D"sans-serif">I just wondering, if anyone outthere
can help me. I am currently kind of lost.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">I have an embedded powerpc based sys=
tem
running with kernel 2.6.20. &nbsp;The system has only two serial lines
and no PS/2 or USB support. Therefore I control the system via a serial
console ( passing the commandline arg: console=3DttyS0,57600) and a termina=
l.</font>
<br><font size=3D2 face=3D"sans-serif">A getty program is running on /dev/c=
onsole,
which gives me a login: prompt, so I can login via the serial line ttyS0.</=
font>
<br><font size=3D2 face=3D"sans-serif">All is working pretty perfect.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">So far so good. And now here comes my
problem. </font>
<br><font size=3D2 face=3D"sans-serif">To add a better MMI in the future I
want to use the graphic card as an output.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">I added a &nbsp;graphic card to the
system. The kernel configuration includes framebuffer support for that
particular graphic card. </font>
<br><font size=3D2 face=3D"sans-serif">After booting the kernel, I can see
a /dev/fb0 device and testing with 'echo &quot;hello&quot; &gt; /dev/fb0',
the message &quot;hello&quot; is displayed on the screen. </font>
<br><font size=3D2 face=3D"sans-serif">Also if I add the commandline arg: c=
onsole=3Dtty
console=3DttyS0,57600 , I get all kernel messages displayed, not only on
the serial line, but also on the screen via the framebuffer.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">So basically, what I want is graphic=
al
output (dev/fb0) with serial input (/dev/ttyS0). The user sees a login
prompt on the screen and can enter characters by a terminal program connect=
ed
to the serial line.</font>
<br><font size=3D2 face=3D"sans-serif">Right to that point I always used the
serial console for user interaction. By adding only the commandline argument
console=3Dtty, I get a nice login prompt on the graphic screen. BUT I have
no input via the serial line???</font>
<br>
<br><font size=3D2 face=3D"sans-serif">So, how do I connect the serial line
/dev/ttySx &nbsp;to the standard input path of the virtual console.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Any hint is welcomed. Any manuals to
read are also welcomed. </font>
<br>
<br><font size=3D2 face=3D"sans-serif">Thanx</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Harald Br=FCggemann</font>
<br><font size=3D2 face=3D"sans-serif"><br>
--------------------------------------------------------<br>
Harald Br=FCggemann<br>
Rockwell Collins Deutschland GmbH<br>
Grenzh=F6ferWeg 36<br>
D-69046 Heidelberg<br>
Germany<br>
 <br>
Phone:&nbsp;&nbsp;&nbsp;&nbsp; +49 - 6221 - 512 484<br>
Fax:&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;+49 - 6221 - 512
301<br>
 <br>
e-mail:&nbsp;&nbsp;&nbsp;hbruegge@rockwellcollins.com</font>
--=_alternative 0038EE7FC1257296_=--
