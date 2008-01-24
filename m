Return-Path: <bgholikh@cisco.com>
Received: from sj-iport-3.cisco.com (sj-iport-3-in.cisco.com [171.71.176.72])
	by ozlabs.org (Postfix) with ESMTP id EB570DDE45
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Jan 2008 09:36:20 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Failed to mount rootfs
Date: Thu, 24 Jan 2008 14:25:27 -0800
Message-ID: <F795765B112E7344AF36AA911279641502D1A9F6@xmb-sjc-212.amer.cisco.com>
In-Reply-To: <47990D51.9080803@scram.de>
References: <F795765B112E7344AF36AA911279641502D1A9F4@xmb-sjc-212.amer.cisco.com>
	<47990D51.9080803@scram.de>
From: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
To: "Jochen Friedrich" <jochen@scram.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Jochen,=20

>=20
> > device-tree: Duplicate name in /, renamed to "chosen#1"
>=20
> > And here is the device tree:
> >     chosen {
> >         linux,stdout-path =3D "/soc8541@e0000000/serial@4600";
> >     };
> >     chosen {
> >         name =3D "chosen";
> >         bootargs =3D "root=3D/dev/ram rw console=3DttyS1,115200";
> >         linux,platform =3D <600>;
> >         linux,initrd-start =3D <1ef33000>;
> >         linux,initrd-end =3D <1fe190aa>;
> >         linux,stdout-path =3D "/soc8541@e0000000/serial@4600";
> >     };
>=20
> you can't have two chosen nodes. Linux renames the second one=20
> to chosen#1 and thus can't find the kernel arguments.
>
I do not know why it is creating two chosen node. In my dts file I have
placed one empty chosen node:=20
chosen{
	};
If I do not do this,  I get the following error during boot process:

libfdt: FDT_ERR_TRUNCATED
Failed creating the /chosen node (0x00C00000), aborting.

Any reason??
=20
Thanks,
Bizhan
