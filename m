Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Thu, 30 Jan 2003 14:16:57 -0700
From: Matt Porter <porter@cox.net>
To: brian.auld@adic.com
Cc: porter@cox.net, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Trying to use ELDK to build Ebony/440GP
Message-ID: <20030130141657.B25221@home.com>
References: <995FF289C9D69747A09E42992644595405B23635@penguin.adic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <995FF289C9D69747A09E42992644595405B23635@penguin.adic.com>; from brian.auld@adic.com on Thu, Jan 30, 2003 at 01:02:59PM -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jan 30, 2003 at 01:02:59PM -0800, brian.auld@adic.com wrote:
> Matt,
>
> Thanks for the response. I was pretty surprised myself and to say the least
> am not having a very good day.
>
> Regarding the linuxppc_2_4_devel build attempt, these were the steps I took:
>
> In fact, I'm going to run it again on my linux box as I regurgitate the
> steps I previuosly took:
>
> Prerequisites:
> ==============
> - running RH8.0
> - ELDK 2.0.2 installed with ppc_4xx tool chain (check)
> - linuxppc_2_4_devel obtained from monte vista mirror (check)
> (1) top-level Makefile hacked to read:
>     - ARCH := ppc
>     - CROSS_COMPILE = ppc_4xx-
> (1) make mrproper
> (2) make ebony_config
> (3) make oldconfig
>     - I accept default(s) for about 10 options I'm prompted for.
> (4) make dep
> (5) make zImage
>
> When I run make zImage, I get the following error message:

> /opt/eldk/usr/src/linuxppc_2_4_devel/include/linux/kernel.h:10: stdarg.h: No
> such file or directory

Interesting, it's not picking up stdarg.h from down in the gcc-lib/
hierarchy.  Probably an ELDK install problem...hopefully Wolfgang
is reading this thread since he should have a suggestion on what have
might gone wrong with your installation.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
