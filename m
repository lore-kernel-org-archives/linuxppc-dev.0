Return-Path: <dgibson@ozlabs.org>
Date: Thu, 19 Jul 2007 11:32:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 05/61] bootwrapper: Change cuImage .gitignore entry to
	cuImage.*
Message-ID: <20070719013214.GA20458@localhost.localdomain>
References: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
	<20070718013301.GD15238@ld0162-tx32.am.freescale.net>
	<20070718014200.GB18251@localhost.localdomain>
	<469E3B27.6040406@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <469E3B27.6040406@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 18, 2007 at 11:09:11AM -0500, Scott Wood wrote:
> David Gibson wrote:
> > On Tue, Jul 17, 2007 at 08:33:01PM -0500, Scott Wood wrote:
> > 
> >>Signed-off-by: Scott Wood <scottwood@freescale.com>
> >>---
> >> arch/powerpc/boot/.gitignore |    4 +---
> >> 1 files changed, 1 insertions(+), 3 deletions(-)
> >>
> >>diff --git a/arch/powerpc/boot/.gitignore b/arch/powerpc/boot/.gitignore
> >>index eec7af7..3270335 100644
> >>--- a/arch/powerpc/boot/.gitignore
> >>+++ b/arch/powerpc/boot/.gitignore
> >>@@ -18,9 +18,7 @@ kernel-vmlinux.strip.c
> >> kernel-vmlinux.strip.gz
> >> mktree
> >> uImage
> >>-cuImage
> >>-cuImage.bin.gz
> >>-cuImage.elf
> >>+cuImage.*
> >> zImage
> >> zImage.chrp
> >> zImage.coff
> > 
> > 
> > Err... your new wildcard won't match plain 'cuImage'.
> 
> When is plain "cuImage" ever generated anymore?

Oh, yes...

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
