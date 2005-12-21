Return-Path: <clark@esteem.com>
Received: from forward.hsphere.cc (forward-dummy9.hsphere.cc [216.157.144.9])
	by ozlabs.org (Postfix) with SMTP id 30FD368952
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Dec 2005 04:09:35 +1100 (EST)
Content-Type: text/html; charset="us-ascii"
MIME-Version: 1.0
From: <clark@esteem.com>
To: linuxppc-dev@ozlabs.org, inuxppc-embedded@ozlabs.org,
	Jeff.Fellin@rflelect.com
Date: Wed, 21 Dec 2005 12:02:48 -0500
Message-Id: <20051221170935.30FD368952@ozlabs.org>
Subject: Re: Power Pc 405EP
Reply-To: clark@esteem.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

<br />We have a device that uses the 405EP. If you are familiar with portin=
g the 405GP then its not that much more difficult. Its just a matter of fin=
ding a tree that has support for the 405EP (several don't). We had one prob=
lem with the serial port baud rate at a particular speed but I can't remebe=
r exactly what. I can't look right now as I'm exiled to WinDOS doing circui=
t board work at the moment. We are using 2.4.27 with the NAPI patch and we =
are quite pleased with it.<br /> <br /><br /><strong>On Wed Dec 21 11:25 , =
Jeff.Fellin@rflelect.com sent:<br /><br /></strong><blockquote style=3D"bor=
der-left: 2px solid rgb(245, 245, 245); margin-left: 5px; margin-right: 0px=
; padding-left: 5px; padding-right: 0px;"><br />=0D
We currently have a product implemented on a 405GP processor, and are<br />=
=0D
considering<br />=0D
changing to a 405EP processor, since we need two Ethernet ports on the<br /=
>=0D
board. For<br />=0D
various reasons we are using Linux-2.4-18 for our system base, with<br />=
=0D
busybox.<br />=0D
<br />=0D
If you know of any difficulty with doing a port of Linux, device drivers to=
<br />=0D
this platform<br />=0D
I would appreciate your reply.<br />=0D
<br />=0D
Thank you<br />=0D
Jeff Fellin<br />=0D
RFL Electronics<br />=0D
<a href=3D"javascript:top.opencompose('Jeff.Fellin@rflelect.com','','','')"=
>Jeff.Fellin@rflelect.com</a><br />=0D
973 334-3100, x 327<br />=0D
<br />=0D
_______________________________________________<br />=0D
Linuxppc-dev mailing list<br />=0D
<a href=3D"javascript:top.opencompose('Linuxppc-dev@ozlabs.org','','','')">=
Linuxppc-dev@ozlabs.org</a><br />=0D
<a target=3D"_blank" href=3D"parse.pl?redirect=3Dhttps%3A%2F%2Fozlabs.org%2=
Fmailman%2Flistinfo%2Flinuxppc-dev">https://ozlabs.org/mailman/listinfo/lin=
uxppc-dev</a><br />=0D
</blockquote>=0D
<BR>=
