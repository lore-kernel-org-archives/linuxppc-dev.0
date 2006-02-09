Return-Path: <s.egbert@sbcglobal.net>
Received: from smtp112.sbc.mail.mud.yahoo.com (smtp112.sbc.mail.mud.yahoo.com
	[68.142.198.211]) by ozlabs.org (Postfix) with SMTP id D1CE267A59
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Feb 2006 18:56:35 +1100 (EST)
Message-ID: <43EAF5EC.7050204@sbcglobal.net>
Date: Wed, 08 Feb 2006 23:57:32 -0800
From: "S. Egbert" <s.egbert@sbcglobal.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH 00/10] Updated ML300 & ML403 patches
References: 43CC5453.3060702@xilinx.com
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> > Really, this isn't statically defined anyway.  The bootloader
> > (u-boot or zImage) passes the memory size into the kernel; and in
> > fact the kernel command line; or the board setup code can restrict
> > the amount of mem used by the kernel.  XPAR_MEM_* isn't used by the
> > kernel proper at all.
> >
> > - Peter
>
> Thanks for the comments.
>
> Another issue we need to discuss is if/how to support the xilinx
> generated BSP in the kernel proper; but I'll leave that for a
> different email.
>
> If there's enough interest; I'll setup another git tree for the virtex
> specific patches.

I, for one, am interested in helping with the Virtex specific patches.
Is there a URL for this?  git://?


S. Egbert
