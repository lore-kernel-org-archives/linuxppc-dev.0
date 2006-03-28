Return-Path: <geoffrey.levand@am.sony.com>
Received: from mail8.fw-bc.sony.com (mail8.fw-bc.sony.com [160.33.98.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BD2F067A00
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2006 06:06:21 +1100 (EST)
Message-ID: <44298929.1060003@am.sony.com>
Date: Tue, 28 Mar 2006 11:06:17 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Hollis Blanchard <hollis@penguinppc.org>
Subject: Re: make install on ppc
References: <f78eb6c06abb98fbc1cf8ae32bbf2268@penguinppc.org>
In-Reply-To: <f78eb6c06abb98fbc1cf8ae32bbf2268@penguinppc.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hollis Blanchard wrote:
> On Mar 26, 2006, at 7:56 PM, Brent Cook wrote:
> 
>> On Sunday 26 March 2006 19:42, Jin Qi Huang wrote:
>>> I also think the 'make install' is very useful, now on ia32, the
> 'make
>>> install' provided by the latest kernel linux-2.6.16 not only create
>>> initrd, copy vmlinuz and System.map to /boot directory, but also 
>>> update
>>> grub, ppc32 does not provide this useful feature, maybe it is a pity!
> 
> The feature sounds like a good idea to me, even if it's just the 
> copying files part. Do any PPC distros provide a working installkernel 
> script?

Problem is for multi-platform binary builds, 'install' could mean different
things for the different platforms, so to support install, there needs
to be some way to tell the build system what 'install' means that also
works with the muti-platform makefile logic.  The current powerpc makefiles
don't have this, and it would take some non-trivial rework to add it.

There is also the question of what install means when cross building.

I run make from a script that I tell the platform.  The script does
what's needed for that platform to get it built and installed.

-Geoff
