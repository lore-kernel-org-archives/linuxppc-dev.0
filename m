Message-ID: <018c01c2c812$d70f35e0$81093c09@MDW600X>
From: "Michael Washburn" <mwashburn@citlink.net>
To: <nitesh_ppc@lycos.com>, <linuxppc-embedded@lists.linuxppc.org>
References: <JENEEIGJCHOHEBAA@mailcity.com>
Subject: Re: Howto install bootloader using jtag?
Date: Wed, 29 Jan 2003 22:51:15 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Depending on what JTAG debugger you're using, there should be a way to
download and execute the S-Rec file (usually a .mot file). The bootloader
file provided by Emdedded Planet is actually an executable that contains the
boot loader image. You should be able to download and execute it in one
simple step.

Mike Washburn
----- Original Message -----
From: "Nitesh Goyal" <nitesh_ppc@lycos.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Wednesday, January 29, 2003 9:45 PM
Subject: Howto install bootloader using jtag?


>
> Hi,
> I'm using a IBM PPC 405GP board(from embeddedplanet) I accidently
> deleted the bootloader.
>
> I have the bootloader srecord image on my host, but I do not know how to
> burn it on board using JTAG ?
>
> Is there a utility available that I can use on host to download the
> bootloader image to tbe board ?
>
> Thanks,
> NItesh
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
