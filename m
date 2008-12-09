Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6AD54DDF06
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 09:07:29 +1100 (EST)
Subject: Re: [RFC/PATCH] powerpc: consistent memory mapping.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ilya Yanok <yanok@emcraft.com>
In-Reply-To: <1228847026-5857-1-git-send-email-yanok@emcraft.com>
References: <1228847026-5857-1-git-send-email-yanok@emcraft.com>
Content-Type: text/plain
Date: Wed, 10 Dec 2008 09:07:07 +1100
Message-Id: <1228860427.22413.29.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-12-09 at 21:23 +0300, Ilya Yanok wrote:
> Defining the start virtual address of the consistent memory
> in configs leads to overlapping of the consistent area with
> the other virtual regions (fixmap, pkmap, vmalloc). Defaults from
> current kernel just set consistent memory area to be somewhere
> high in the vmalloc area and then you need to pray there will be
> not enough vmalloc allocations to overlap.

 .../...

What about just ripping that consistent memory implementation out
completely and using the normal vmalloc/ioremap allocator instead ?

Any reason not to ?

Cheers,
Ben.
