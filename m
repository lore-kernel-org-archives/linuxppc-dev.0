Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CD05967A88
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Feb 2005 13:00:12 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Fedin <sonic_amiga@rambler.ru>
In-Reply-To: <20050222130646.25bc9520.sonic_amiga@rambler.ru>
References: <20050222121809.351088dc.sonic_amiga@rambler.ru>
	<20050222093208.GE27891@gate.ebshome.net>
	<20050222130646.25bc9520.sonic_amiga@rambler.ru>
Content-Type: text/plain
Date: Wed, 23 Feb 2005 12:59:22 +1100
Message-Id: <1109123962.5412.164.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] Non-DMA mode for floppy on PowerPC
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-02-22 at 13:06 -0500, Pavel Fedin wrote:
> On Tue, 22 Feb 2005 01:32:09 -0800
> Eugene Surovegin <ebs@ebshome.net> wrote:
> 
> > Please, be patient and don't repost the same stuff every day.
> 
>  Ok. How long does it take for a patch to get included into the kernel? I
> posted if two weeks ago for the first time and nothing happened. In LKML also nobody answers.

Maybe you haven't noticed but 2.6.11 is actually in late -rc phase and
not open to such patches.

Just be patient. Patches posted to linuxppc-dev or linuxppc64-dev are
generally not lost as we have an automatic patch tracking system there.
It will be picked up at one point.

Also, it's a good habit, _especially_ if you re-post your patch, to
actually repost it properly re-based against the latest linux bk tree,
or at least the latest -rc, and with the proper format (which is -p1),
maintainers just don't have time to play at fixing patches.

Ben.
