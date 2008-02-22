Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound4-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4B139DDFE4
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Feb 2008 06:07:37 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Xilinx PowerPC
Date: Fri, 22 Feb 2008 11:07:32 -0800
In-Reply-To: <4726E9350007F2E5@hawk.dcu.ie>
References: <20080222181124.5F07079007D@mail120-dub.bigfish.com>
	<4726E9350007F2E5@hawk.dcu.ie>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: <alan.casey5@mail.dcu.ie>,
	"Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20080222190734.2F4581AA0064@mail76-sin.bigfish.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Alan Casey [mailto:alan.casey5@mail.dcu.ie]
> Sent: Friday, February 22, 2008 10:58 AM
> To: Stephen Neuendorffer; Grant Likely
> Cc: linuxppc-embedded
> Subject: RE: Xilinx PowerPC
>=20
>=20
> >-- Original Message --
> >Subject: RE: Xilinx PowerPC
> >Date: Fri, 22 Feb 2008 10:11:19 -0800
> >From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
> >To: <alan.casey5@mail.dcu.ie>,
> >	"Grant Likely" <grant.likely@secretlab.ca>
> >Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
> >
> >
> >>
> >> Hi,
> >>
> >>   Just wondering - is it possible to use U-Boot on the Xilinx
XUPV2PRO
> >>   board or any similar tools (such as libfdt?) to copy a Linux
kernel
> >and
> >>
> >>   ramdisk filesystem from a SystemACE card to memory, uncompress
them
> >and
> >>
> >>   boot the Linux kernel etc?? If so is there any notes/docs about
how
> >to
> >> do
> >>   this or similar online anywhere?
> >>
> >>   Any info. appreciated,
> >>   Regards&Thanks,
> >>   Alan.
> >
> >In theory, yes...  All the infrastructure to do this exists, but I
don't
> >know of anyone who as actually tried it yet with ARCH=3Dpowerpc
kernels.
> >There
> >
> >Steve
>=20
>  So i can try the latest official U-Boot releases with the ML300
configuration
> or is there a port or similar of U-Boot for the Xilinx XUPV2PRO
board??
>=20
>   Regards&Thanks,
>   Alan.
>=20
>=20

That's probably your best starting point....  There is a uboot
application note on the Xilinx website (XAPP 542), but it's a little
thin on porting information.

Steve
