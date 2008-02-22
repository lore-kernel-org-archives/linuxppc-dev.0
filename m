Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound2-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 437B6DDF85
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Feb 2008 05:11:33 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Xilinx PowerPC
Date: Fri, 22 Feb 2008 10:11:19 -0800
In-Reply-To: <4726E9350007F0D6@hawk.dcu.ie>
References: <fa686aa40802211102i7f636447hfca0f8e1673042a5@mail.gmail.com>
	<4726E9350007F0D6@hawk.dcu.ie>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: <alan.casey5@mail.dcu.ie>,
	"Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20080222181124.5F07079007D@mail120-dub.bigfish.com>
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

>=20
> Hi,
>=20
>   Just wondering - is it possible to use U-Boot on the Xilinx XUPV2PRO
>   board or any similar tools (such as libfdt?) to copy a Linux kernel
and
>=20
>   ramdisk filesystem from a SystemACE card to memory, uncompress them
and
>=20
>   boot the Linux kernel etc?? If so is there any notes/docs about how
to
> do
>   this or similar online anywhere?
>=20
>   Any info. appreciated,
>   Regards&Thanks,
>   Alan.

In theory, yes...  All the infrastructure to do this exists, but I don't
know of anyone who as actually tried it yet with ARCH=3Dpowerpc kernels.
There=20

Steve
