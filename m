Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id D4AB1DDE1C
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 17:55:15 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Mon, 28 May 2007 09:55:07 +0200
To: Rob Landley <rob@landley.net>
Subject: Re: Porting "prep" from ppc to powerpc.
Message-ID: <20070528075507.GA6633@iram.es>
References: <200705252238.39819.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200705252238.39819.rob@landley.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 25, 2007 at 10:38:39PM -0400, Rob Landley wrote:
> Is anyone already doing this?  

I'm interested but I don't have the time right now.

> I asked around here a few weeks ago and got the 
> advice:
> 
> > In theory.. copy the files from ppc/platforms/prep.* to
> > powerpc/platforms/prep/ 
> > and make some Kconfigs and see what breaks :)
> 
> Unfortunately, there isn't a ppc/platforms/prep.  Under arch/ppc there's:
> 
> ./boot/simple/misc-prep.c
> ./boot/simple/prepmap.c
> ./boot/utils/mkprep.c
> ./configs/prep_defconfig
> ./platforms/prep_pci.c
> ./platforms/prep_setup.c
> ./syslib/prep_nvram.c
> 
> And I'm not sure which are relevant.  Any hints?

I was thinking of writing a bootwrapper that would
convert residual data to flat device tree. There
is a lot of valuable information in the residual data,
like the interrupt routing (which is correct if you 
can read the spec, which is not what the code in
arch/ppc did).


	Gabriel
