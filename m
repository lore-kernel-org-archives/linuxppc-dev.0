Return-Path: <cyrilbur@gmail.com>
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com
 [IPv6:2607:f8b0:400e:c03::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 060A61A01A3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 14:22:56 +1000 (AEST)
Received: by pabsx10 with SMTP id sx10so89332768pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Apr 2015 21:22:53 -0700 (PDT)
Message-ID: <1428898964.2881.9.camel@cyril>
Subject: Re: [PATCH 0/2] Add a MTD driver for OpenPower PNOR flash
From: Cyril Bur <cyrilbur@gmail.com>
To: linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>
Date: Mon, 13 Apr 2015 14:22:44 +1000
In-Reply-To: <1427868330.741478.119647151764.0.gpush@pablo>
References: <1427868330.741478.119647151764.0.gpush@pablo>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
 Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-04-01 at 14:05 +0800, Jeremy Kerr wrote:
> Hi all,
> 
> This series implements a simple mtd device to allow access to the PNOR
> flash on OpenPower machines. The flash is accessed through firmware
> calls.
> 
> Patch 1/2 adds the Linux interface to these calls. Patch 2/2 adds a mtd
> driver that uses these calls.
> 
> Because there's two subsystems involved here, there are a couple of
> methods to merge this:
> 
>  1) The powerpc folks take 1/2, and the mtd folks take 2/2, to be
>     applied once 1/2 is available (Michael has created a topic branch for
>     this in the past, which can make things a little easier), or
> 
>  2) One of the maintainers takes both patches, once the other has acked
>     their patch. I'd suggest that it goes through the powerpc tree in
>     this case, as that will be less likely to conflict.
> 
Ping about this patchset. What do the MTD maintainers think?

Hi David,

Jeremy mentioned you might be interested in seeing these.


Thanks,

Cyril

> Either way, I'm happy.
> 
> Cheers,
> 
> 	
> Jeremy
> 
> ---
> Cyril Bur (2):
>       powerpc/powernv: Add interfaces for flash device access
>       drivers/mtd: add powernv flash MTD abstraction driver
> 
