Return-Path: <carcadiz@hotmail.com>
Received: from blu139-omc3-s16.blu139.hotmail.com
	(blu139-omc3-s16.blu139.hotmail.com [65.55.175.216])
	by ozlabs.org (Postfix) with ESMTP id 7EF54DDE11
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Dec 2007 20:38:10 +1100 (EST)
Message-ID: <BLU106-W420C40497B4E7C784AC4B6CA5C0@phx.gbl>
From: "Pedro Luis D. L." <carcadiz@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: Getting this error when mounting the jffs2 partition created
	using	mkImage..
Date: Wed, 19 Dec 2007 10:38:09 +0100
In-Reply-To: <OF51AFEA66.838FE3D0-ON852573B5.0067739C-852573B5.00689046@RFLELECT.COM>
References: <OF51AFEA66.838FE3D0-ON852573B5.0067739C-852573B5.00689046@RFLELECT.COM>
Content-Type: text/plain; charset="iso-8859-1"
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


Ravi wrote:
>
> Hi All,
>       I have u-boot based bootloader on our custom board based on ppc405E=
P.
> Various partitions are..
> Amd/Fujitsu Extended Query Table at 0x0040
> RoadRunner: CFI does not contain boot bank location. Assuming top.
> number of CFI chips: 2
> cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
> Creating 5 MTD partitions on "RoadRunner":
> 0x03fc0000-0x04000000 : "U-Boot based RR Boot loader"
> 0x03fa0000-0x03fc0000 : "U-Boot Env Storage"
> 0x03f80000-0x03fa0000 : "U-Boot Redundant Env Storage"
> 0x027c0000-0x03f80000 : "Kernel Image"
> 0x00000000-0x027c0000 : "JFFS2 Linux FS"
>
> I have used the following command to create the jffs2 file system image.
> $BLDTOOLS/mkfs.jffs2 -b -e 0x10000 -d $JFFS2 -p 0x27c0000 -o rr-app_64.im=
g
> ${MKIMAGE} -T filesystem -n 'RR App Image for AMD' -d rr-app_64.img uRR-a=
pp_64

Hi,
I'm not using that board so I can not tell which is the correct value, but =
looking at the output you send it looks like the erase size you passed when=
 creating the image file is wrong. I suggest you to find the appropiate val=
ue and create the image. For an mpc5200b it happened to be 0x20000. May thi=
s would help.

Good luck.

Pedro.

_________________________________________________________________
La vida de los famosos al desnudo en MSN Entretenimiento
http://entretenimiento.es.msn.com/=
