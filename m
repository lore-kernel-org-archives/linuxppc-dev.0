Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from mail130-sin-R.bigfish.com (mail-sin.bigfish.com [207.46.51.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 24D60DDF30
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 06:38:53 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Making the Kernel
Date: Mon, 9 Jun 2008 13:22:30 -0700
In-Reply-To: <1213042163.7776.4.camel@Phoebe>
References: <1213042163.7776.4.camel@Phoebe>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Jacob Holladay Poteet" <txtbox@gmail.com>,
	<linuxppc-dev@ozlabs.org>
Message-Id: <20080609202244.6B58C2B8052@mail130-sin.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The kernel at git.xilinx.com has a rule to make zImage.virtex.  Note
that this elf file will almost certainly *not* fit in blockram, hence
you can't use it to 'make a bitstream'.  You can use it to generate a
SystemAce file, however.

If you are using a current mainline kernel, then you need to make a
simpleImage, which requires having a dts file that starts with the
'virtex-' prefix.

Steve

> -----Original Message-----
> From: linuxppc-dev-bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-
> bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org] On Behalf Of Jacob
Holladay Poteet
> Sent: Monday, June 09, 2008 1:09 PM
> To: linuxppc-dev@ozlabs.org
> Subject: Making the Kernel
> =

> Good Afternoon,
> =

> I've gone through the process of configuring a kernel for my Xilinx
> board design using the mhs->devtree, dts+'make menuconfig'
> options->'make all' process and things seem to have succeeded. I was
> under the expectation that I would find a file
> arch/powerpc/boot/zImage.virtex, which is a type of .elf file that I
can
> use to make a bitstream, but I didn't find this said file in the
output.
> I found several zImage files (zImage,
> zImage.pmac,.miboot,.chrp,.lds,.cofflds), but none of them had the
> desired '.virtex' extension. Am I looking for something that doesn't
> exist? If not, can someone help me generate the necessary file?
> =

> This is my first time through this process so I appreciate your
advice.
> =

> Sincerely,
> Jake Poteet
> =

> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
