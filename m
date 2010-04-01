Return-Path: <cbouatmailru@gmail.com>
Received: from mail-bw0-f218.google.com (mail-bw0-f218.google.com
	[209.85.218.218]) by ozlabs.org (Postfix) with ESMTP id 94EDAB7D08
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  2 Apr 2010 02:14:56 +1100 (EST)
Received: by bwz10 with SMTP id 10so1686854bwz.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 01 Apr 2010 08:14:53 -0700 (PDT)
Date: Thu, 1 Apr 2010 19:14:50 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Bolko Maass <krautilein@gmx.de>
Subject: Re: poweroff/suspend problems on PowerMac G5
Message-ID: <20100401151450.GA26399@oksana.dev.rtsoft.ru>
References: <alpine.DEB.2.01.1003310430570.5493@bogon.housecafe.de>
	<20100331132300.GA15951@oksana.dev.rtsoft.ru>
	<alpine.DEB.2.01.1003311131250.5493@bogon.housecafe.de>
	<20100401145642.70d5eab0.krautilein@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20100401145642.70d5eab0.krautilein@gmx.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Thu, Apr 01, 2010 at 02:56:42PM +0200, Bolko Maass wrote:
> Hi everybody!
> 
> Hope this list is even the right place to bring this up, but I've
> exhausted everything else I could think of, so here it goes.
> 
> The problem is that my PowerMac G5 Quad machine ("PowerMac 11,2",
> Gentoo, linux-2.6.34-rc2) will not power down if suspend
> infrastructure (CONFIG_HIBERNATION) is in the kernel.
...
> It will
> stop all services and halt, but never power down. This is when
> actually trying to suspend

So CONFIG_HIBERNATION breaks suspend? Hm. How do you try
to suspend? echo mem > /sys/power/state?

> as well as when just trying to shut
> down the machine.

How do try to shut down the machine? halt/poweroff commands?

>From a brief look, I don't see how CONFIG_HIBERNATION may change
halt/poweroff code flow in the kernel...

Can you show us a boot log of working and not working kernels?
And .config files you use.

..maybe for some reason PMU/SMU modules didn't get loaded?

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
