Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id A8F30DDDF9
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 15:23:15 +1100 (EST)
Date: Thu, 29 Nov 2007 15:23:14 +1100
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Increase the upper bound on NR_CPUS.
Message-ID: <20071129042314.GN24243@bakeyournoodle.com>
References: <20071129041603.GM24243@bakeyournoodle.com>
	<1196309836.7875.3.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1196309836.7875.3.camel@concordia>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 29, 2007 at 03:17:16PM +1100, Michael Ellerman wrote:
> On Thu, 2007-11-29 at 15:16 +1100, Tony Breeds wrote:
> > Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
> > 
> > ---
> > why not?
> 
> How big is say a pseries_defconfig with NR_CPUS = 1024 ?

This is a ppc64_defconfig, with a couple of extra patches, and
NR_CPUS=1024

tony@Sprygo:~/scratch/working$ size ../working_out/arch/powerpc/boot/zImage.{pmac,pseries,iseries} ../working_out/vmlinux
   text    data     bss      dec     hex filename
3697092    5356   48232  3750680  393b18 ../working_out/arch/powerpc/boot/zImage.pmac
3697092    5356   48232  3750680  393b18 ../working_out/arch/powerpc/boot/zImage.pseries
8101340 4994176  815544 13911060  d44414 ../working_out/arch/powerpc/boot/zImage.iseries
8101340 4994176  815544 13911060  d44414 ../working_out/vmlinux

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
