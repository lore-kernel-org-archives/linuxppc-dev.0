Return-Path: <jdl@jdl.com>
To: "fengcheng lu" <sparking.lu@gmail.com>
Subject: Re: Anybody applied the patch "Add 85xx CDS to arch/powerpc" on the
	2.6.16. I failed to apply it:-(
In-Reply-To: Your message of "Wed, 05 Apr 2006 22:32:23 +0800."
	<e9aafa30604050732g6ede1f37h450243613bcbca85@mail.gmail.com>
References: <e9aafa30604050732g6ede1f37h450243613bcbca85@mail.gmail.com> 
Date: Wed, 05 Apr 2006 09:38:10 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1FR998-0004hM-Ha@jdl.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day "fengcheng lu" mumbled:
> 
>     I downloaded this patch from
> http://patchwork.ozlabs.org/linuxppc/patch?id=3D4910. But I failed to apply
> it. The following is the output:
> debian:/usr/src/linux-2.6.16# patch -p1 <powerpc.patch
> patching file arch/powerpc/config/mpc85xx_cds_deconfig
> patching file arch/powerpc/platforms/85xx/Kconfig
> Hunk #1 FAILED at 11
> 1 out of 1 hunk FAILED -- saving rejects to file
> arch/powerpc/platforms/85xx/Kconfig.rej
> patching file arch/powerpc/platforms/85xx/Makefile
> Hunk #1 FAILED at 3
> 1 out of 1 hunk FAILED -- saving rejects to file
> arch/powerpc/platforms/85xx/Makefile.rej
> patching file arch/powerpc/platforms/85xx/mpc85xx_cds.c
> patching file arch/powerpc/platforms/85xx/mpc85xx_cds.h
> patching file include/asm-ppc/mpc85xx.h
> 
> It looks seem the Makefile and Kconfig don't match yours.

What was the repository against which you applied this patch?
Was it Linus' or Paul's?  I suspect it needs to be Paul's
powerpc.git repository.

HTH,
jdl
