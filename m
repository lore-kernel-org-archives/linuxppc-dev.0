Return-Path: <John.Linn@xilinx.com>
Received: from mail118-va3-R.bigfish.com (mail-va3.bigfish.com
	[216.32.180.113])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 865DEDEE8E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Jul 2008 02:26:28 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Booting ML405 (Kernel panic - not syncing: No init found)
Date: Wed, 9 Jul 2008 10:06:58 -0600
In-Reply-To: <20080709143318.GB26524@secretlab.ca>
References: <48744475.2080605@cdac.in> <20080709143318.GB26524@secretlab.ca>
From: "John Linn" <John.Linn@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>, "neeraj garg" <neerajg@cdac.in>
Message-Id: <20080709160659.EE3F6E28065@mail118-va3.bigfish.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The only difference I see is the tools, we are using ELDK 4.1 for now.

I have tested this on the ML405 in the past, not for a bit as our
automated testing uses an NFS root.

Since this is arch/ppc (it appears, no boot line), we have stopped work
on this architecture and are now encouraging (maybe a stronger word is
needed) you to move to arch/powerpc.

The arch/ppc was last stable at git tag last-arch-ppc and I know it
started getting more unstable after I started pulling in 2.6.26-rcx.  We
won't be doing any more changes to arch/ppc.

-- John

> -----Original Message-----
> From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+john.linn=3Dxilinx.com@ozlabs.org] On Behalf Of Grant Likely
> Sent: Wednesday, July 09, 2008 8:33 AM
> To: neeraj garg
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Booting ML405 (Kernel panic - not syncing: No init found)
> =

> On Wed, Jul 09, 2008 at 10:24:13AM +0530, neeraj garg wrote:
> > Hi,
> >
> > I am trying to boot ML405 with Linux source code downloaded from
> > http://www.git.xilinx.com . My cross compiler tool chain version is
> > gcc-3.4.1, glibc-2.3.2 and binutils-2.15. I have also downloaded
RAMDISK
> > from same url (http://www.git.xilinx.com). When I download
> > zImage.initrd.elf using XMD everything goes fine, untill RAMDISK is
> > uncompressed, I get following messages :
> >
> <snip>
> >                                           [    3.736691] Failed to
> > execute /sbin/init.  Attempting defaults...
> > [    3.748073] Kernel panic - not syncing: No init found.  Try
passing
> > init=3D option to kernel.
> > [    3.772040] Rebooting in 180 seconds..[  183.487314]   Signal: 8
> >
> =

> Try changing the kernel parameters line to specify init=3D/bin/sh and
see
> what happens.
> =

> g.
> =

> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
