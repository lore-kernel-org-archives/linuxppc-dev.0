Return-Path: <jonb@marel.is>
Received: from marel.marel.is (GW-NAT01-ISLNET.marel.is [213.213.131.1])
	by ozlabs.org (Postfix) with ESMTP id A9E5D2BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Nov 2004 23:47:36 +1100 (EST)
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Message-ID: <OF368071C2.FBC6B7BC-ON00256F42.003F3DF3-00256F42.0044E8BB@marel.is>
From: "=?iso-8859-1?Q?J=F3n_Benediktsson?=" <jonb@marel.is>
Date: Thu, 4 Nov 2004 12:32:40 +0000
Content-Type: multipart/alternative;
	boundary="=_alternative 0044E8B800256F42_="
Subject: Handling power failure - MPC5200
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 0044E8B800256F42_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi

I am running Linux 2.4.25, based on linux=5F2=5F4=5Fdevel from Denx, on a c=
ustom=20
MPC5200 board.
The boad has a TPS3705 chip for reset and watchdog.  The chip also=20
provides a powerfail interrupt
when the supply voltage goes below a certain level, which is connected to=20
IRQ0 on the MPC5200.

Capacitors on the supply provide me with some milliseconds to repond to=20
power failure, which I would
like to use to do as much cleanup as possible before power is totally=20
gone.  In particular, I am concerned
with trying to prevent damage to filesystems.  The board has Compact Flash =

and onboard flash which
are used as filesystems.  The board will be used as an industrial=20
controller.

Can anyone point me to examples of how this can be handled ?
Can anyone share experience of a similar setup, which filesystems to=20
select etc ?

Regards,
J=F3n Benediktsson
Marel hf

--=_alternative 0044E8B800256F42_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable


<br><font size=3D2 face=3D"sans-serif">Hi</font>
<br>
<br><font size=3D2 face=3D"sans-serif">I am running Linux 2.4.25, based on
linux=5F2=5F4=5Fdevel from Denx, on a custom MPC5200 board.</font>
<br><font size=3D2 face=3D"sans-serif">The boad has a TPS3705 chip for reset
and watchdog. &nbsp;The chip also provides a powerfail interrupt</font>
<br><font size=3D2 face=3D"sans-serif">when the supply voltage goes below a
certain level, which is connected to IRQ0 on the MPC5200.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Capacitors on the supply provide me
with some milliseconds to repond to power failure, which I would</font>
<br><font size=3D2 face=3D"sans-serif">like to use to do as much cleanup as
possible before power is totally gone. &nbsp;In particular, I am concerned<=
/font>
<br><font size=3D2 face=3D"sans-serif">with trying to prevent damage to fil=
esystems.
&nbsp;The board has Compact Flash and onboard flash which</font>
<br><font size=3D2 face=3D"sans-serif">are used as filesystems. &nbsp;The b=
oard
will be used as an industrial controller.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Can anyone point me to examples of h=
ow
this can be handled ?</font>
<br><font size=3D2 face=3D"sans-serif">Can anyone share experience of a sim=
ilar
setup, which filesystems to select etc ?</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Regards,</font>
<br><font size=3D2 face=3D"sans-serif">J=F3n Benediktsson</font>
<br><font size=3D2 face=3D"sans-serif">Marel hf</font>
<br>
--=_alternative 0044E8B800256F42_=--
