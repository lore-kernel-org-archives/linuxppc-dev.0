Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound7-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 94926DDE0A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Dec 2007 04:56:30 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Linux 2.6 from git.xilinx and XUPV2P
Date: Tue, 11 Dec 2007 09:54:03 -0800
In-Reply-To: <14274035.post@talk.nabble.com>
References: <14274035.post@talk.nabble.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "greenlean" <jmgomez@atc.ugr.es>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20071211175405.B2EACEE0046@mail203-blu.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi!

Unfortunately, at this point, git.xilinx.com is not 'beginner friendly'.
There is a rather complicated set of things that has to be coordinated
between EDK and the linux kernel.  Also, many EDK designs will simply
not work with the Linux drivers.  Today, it is primarily a place for us
to collaborate with the open source community on new development, hence
it also is perhaps less stable than a beginner really wants.

That said:
git.xilinx.com includes all the common EDK drivers.  The only thing you
should need to add is the xparameters file.  Today, this requires
generating the Board Support Package from a recent version of EDK, using
the linux_2_6 OS support and copied into
arch/ppc/platforms/4xx/xparameters/.  Then whenever you run make use
ARCH=3Dppc.

This appnote shows how to use the linux_2.6 BSP:
http://www.xilinx.com/support/documentation/application_notes/xapp969.pd
f

There are also several websites with more information about 'rolling
your own' Linux kernel and root file system (google some combination of
'xilinx' 'virtex' 'ml310' 'ml300' and 'linux'):

http://www.crhc.uiuc.edu/IMPACT/gsrc/hardwarelab/docs/kernel-HOWTO.html
http://www.klingauf.com/v2p/index.phtml
http://www.soe.ucsc.edu/~rios/ml310/ml310_linux.htm
http://www.cs.washington.edu/research/lis/empart/xup_ppc_linux.shtml
http://splish.ee.byu.edu/projects/LinuxFPGA/index.htm

Personally, EDK4.1 works fine for me.  It may be that you are
configuring lots of features in the kernel.  A good start would be the
ml300_defconfig.

Steve

> -----Original Message-----
> From:=20
> linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
> =20
> [mailto:linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@oz
> labs.org] On Behalf Of greenlean
> Sent: Tuesday, December 11, 2007 5:32 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: Linux 2.6 from git.xilinx and XUPV2P
>=20
>=20
> Hi all,
>=20
>  I'm a beginner in Xilinx & Linux world and I'm getting a bit=20
> loose. I'm
> trying to run linux kernel 2.6 that I downloaded from the=20
> xilinx git server
> on the PPC405 of the Xilinx university program Virtex II Pro=20
> (XUPV2P for the
> search engine)  board, and I'm using the compiler ELDK 4.1=20
> (I' ve just read
> this compiler may cause some error so I'll change it, and try the 4.0
> version) and I'm getting a lot of compilation error  and warning.=20
>=20
> I think this is what I should use, Does anybody if I have to=20
> patch this
> kernel or if it is still prepatched??
>=20
> My compiler can find some definitions like TASK_SIZE or=20
> CONFIG_KERNEL_START,
> now I'm solving it writting  the values manually , I google=20
> for the error
> and make the definition where it's needed, but I don't think=20
> this is a good
> idea ;). I think this definitions should be defined in the=20
> .config file,
> because I found the values I wrote on a posted message in this list.
>=20
> Maybe somebody could guide me a bit through this kernel=20
> compilation, or send
> me .config file running. I don't know if a revision in the=20
> project is a good
> way, to put things in situation for beginers.=20
>=20
> Thanks, any info would be interesting.=20
>=20
>=20
>=20
> --=20
> View this message in context:=20
> http://www.nabble.com/Linux-2.6-from-git.xilinx-and-XUPV2P-tp1
> 4274035p14274035.html
> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20
