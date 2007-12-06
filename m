Return-Path: <carcadiz@hotmail.com>
Received: from blu139-omc3-s25.blu139.hotmail.com
	(blu139-omc3-s25.blu139.hotmail.com [65.55.175.225])
	by ozlabs.org (Postfix) with ESMTP id 705A8DDE9A
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Dec 2007 01:22:16 +1100 (EST)
Message-ID: <BLU106-W40541C7A5C29E0CF526F13CA6F0@phx.gbl>
From: "Pedro Luis D. L." <carcadiz@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: USB configuration
Date: Thu, 6 Dec 2007 15:10:10 +0100
In-Reply-To: <14192347.post@talk.nabble.com>
References: <14192347.post@talk.nabble.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



> Date: Thu, 6 Dec 2007 05:27:14 -0800
> From: misbah_khan@engineer.com
> To: linuxppc-embedded@ozlabs.org
> Subject: USB configuration
>=20
>=20
> HI all ...

Hi,

> I have configured the Montavista Kernel for USB support and for PPC8272-A=
DS
> board I need to know that how could i test that my USB is working ????
>=20

Try to attach an USB device, like a pendrive,  to an USB port. Then type:=20
dmesg | tail

If the USB support is working properly, you should see some output saying w=
hich device have you attached and where is it mapped.
If you plug a memory stick, you can try to mount it and check that the file=
system is correct.

Pedro.

> Its creating the directory :- /proc/bus/usb/ but doesent contain any file
> under it ????
>=20
>=20
> its also creating the directory :- /sys/bus/usb/   but doesent contain an=
y
> file under it ????
>=20
>=20
> Please let me know the procedure to test whether my USB configuration is =
all
> right ????
>=20
> Thank u=20
> Misbah <><
> --=20
> View this message in context: http://www.nabble.com/USB-configuration-tf4=
956061.html#a14192347
> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

_________________________________________________________________
Tecnolog=EDa, moda, motor, viajes,=85suscr=EDbete a nuestros boletines para=
 estar a la =FAltima
http://newsletters.msn.com/hm/maintenanceeses.asp?L=3DES&C=3DES&P=3DWCMaint=
enance&Brand=3DWL&RU=3Dhttp%3a%2f%2fmail.live.com=
