Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Date: Wed, 12 Nov 2003 08:18:24 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Cc: Dale Farnsworth <dale@farnsworth.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC5200 Patches
Message-ID: <20031112151824.GC31581@ip68-0-152-218.tc.ph.cox.net>
References: <20031110190207.GA12163@zenos.farnsworth.org> <20031112003502.BBA4CC5F59@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031112003502.BBA4CC5F59@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Nov 12, 2003 at 01:34:57AM +0100, Wolfgang Denk wrote:

[snip]
> * Some files/directories have been renamed into 5xxx, others in
>   m5xxx. The same applies to the CONFIG_ options: Maybe we can make
>   this a bit more consistent?
>
>   Given the fact that we use CONFIG_6xx, CONFIG_40x, CONFIG_44x,
>   CONFIG_8xx, ... we should probably use CONFIG_5xxx instead of
>   CONFIG_M5XXX ?

Can I suggest breaking the trend slightly based on comments people have
made about 2.5/2.6?  Let's call it CONFIG_PPC_5xxx (and someday fix all
of the others).

>   We have drivers/i2c/i2c-algo-8xx.c, so maybe we should have
>   i2c-algo-5xxx.c instead of i2c-algo-m5xxx.c ?
>
>   There is include/linux/i2c-algo-8xx.h - how about i2c-algo-5xxx.h
>   instead of i2c-algo-m5xxx.h ?

As others have mentioned, this is too generic, and should someone have
time, 8xx should be renamed m8xx.

>   We have include/asm-ppc/mpc8xx.h and mpc8260.h and ibm4xx.h - maybe
>   we should use mpc5xxx.h instead of m5xxx.h ?

Sounds like a good idea.

> * Does it make sense to add a "Board uses UBoot" config option to
>   individual boards? [BTW: the name is "U-Boot".] If we do something
>   like this (which I'd appreciate) we should do it right - there
>   might be some other boards that use this, too.

My question is, is it possible to support both U-Boot and $(VENDOR
FIRMWARE) in the same build?  If possible I'd like to avoid adding a
question for any type of firmware or a define_bool based on board
selection.  I think we allow for this on Sandpoints, so...

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
