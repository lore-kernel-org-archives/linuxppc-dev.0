Return-Path: <michael@ellerman.id.au>
Date: Tue, 13 Aug 2013 12:23:50 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: Build errors on mainline kernel
Message-ID: <20130813022350.GA9957@concordia>
References: <20130809182446.GA26711@us.ibm.com>
 <1376286123.2066.7.camel@concordia>
 <20130812060228.GA8608@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130812060228.GA8608@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Aug 11, 2013 at 11:02:28PM -0700, Sukadev Bhattiprolu wrote:
> Michael Ellerman [michael@ellerman.id.au] wrote:
> | On Fri, 2013-08-09 at 11:24 -0700, Sukadev Bhattiprolu wrote:
> | > I am tryng to compile clean mainline kernel with a few different config files
> | > and running into errors with some configs.
> | > 
> | > I am building on RHEL6.3 with following binaries:
> | > 
> | > 	gcc (GCC) 4.4.6 20120305 (Red Hat 4.4.6-4)
> | > 	GNU ld version 2.20.51.0.2-5.34.el6 20100205
> | > 	binutils-2.20.51.0.2-5.34.el6.ppc64
> | > 	binutils-devel-2.20.51.0.2-5.34.el6.ppc64
> | > 
> | > I am getting the error with several files and configs, but other configs 
> | > (eg: ppc64_defconfig, pmac32_defconfig) build fine.
> | > 
> | > For instance, with latest mainline kernel (commit 6c2580c) and ppc64_defconfig, I get:
> | 
> | Here you say ppc64_defconfig ..
> 
> That was a stupid typo. ppc64_defconfig works.
> 
> | 
> | > 	make O=linux-obj mrproper
> | > 	make O=linux-obj ppc64e_defconfig
> | 
> | But here you say ppc64e_defconfig ?
> 
> ppc64e_defconfig fails (checked again now).

OK. I don't have a RHEL 6 system around. But I can build
ppc64e_defconfig on debian with gcc 4.4.7-2.

So not sure what's going on.
 
cheers
