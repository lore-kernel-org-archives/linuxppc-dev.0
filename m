Return-Path: <michael@ellerman.id.au>
Message-ID: <1376286123.2066.7.camel@concordia>
Subject: Re: Build errors on mainline kernel
From: Michael Ellerman <michael@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Mon, 12 Aug 2013 15:42:03 +1000
In-Reply-To: <20130809182446.GA26711@us.ibm.com>
References: <20130809182446.GA26711@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-08-09 at 11:24 -0700, Sukadev Bhattiprolu wrote:
> I am tryng to compile clean mainline kernel with a few different config files
> and running into errors with some configs.
> 
> I am building on RHEL6.3 with following binaries:
> 
> 	gcc (GCC) 4.4.6 20120305 (Red Hat 4.4.6-4)
> 	GNU ld version 2.20.51.0.2-5.34.el6 20100205
> 	binutils-2.20.51.0.2-5.34.el6.ppc64
> 	binutils-devel-2.20.51.0.2-5.34.el6.ppc64
> 
> I am getting the error with several files and configs, but other configs 
> (eg: ppc64_defconfig, pmac32_defconfig) build fine.
> 
> For instance, with latest mainline kernel (commit 6c2580c) and ppc64_defconfig, I get:

Here you say ppc64_defconfig ..

> 	make O=linux-obj mrproper
> 	make O=linux-obj ppc64e_defconfig

But here you say ppc64e_defconfig ?

> 	make O=linux-obj arch/powerpc/platforms/85xx/smp.o
> 	  ...
> 
> 	CC      arch/powerpc/platforms/85xx/smp.o
> 	{standard input}: Assembler messages:
> 	{standard input}:240: Error: junk at end of line: `1'
> 	make[2]: *** [arch/powerpc/platforms/85xx/smp.o] Error 1
> 	make[1]: *** [arch/powerpc/platforms/85xx/smp.o] Error 2

So I'm not clear which config you're building.

cheers
