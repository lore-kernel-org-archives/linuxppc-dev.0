Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0109.outbound.protection.outlook.com [65.55.169.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 224A51A0CB8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 02:30:04 +1000 (AEST)
Message-ID: <1442420984.2909.179.camel@freescale.com>
Subject: Re: [BUG] Revert 0b05e2d671c4 'powerpc/32: cacheable_memcpy becomes
 memcpy'
From: Scott Wood <scottwood@freescale.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: Christophe Leroy <christophe.leroy@c-s.fr>, <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 16 Sep 2015 11:29:44 -0500
In-Reply-To: <alpine.DEB.2.11.1509161816310.3951@nanos>
References: <alpine.DEB.2.11.1509161816310.3951@nanos>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-09-16 at 18:23 +0200, Thomas Gleixner wrote:
> With this commit applied, my MPC5200 board fails to boot 4.3-rc1. The
> boot failure is silent.
> 
> Bisection pointed straight to this commit. Reverting it on top of
> 4.3-rc1 works like a charm.

Yes, we've been iterating on a fix for this, and I think the patches posted 
earlier today are ready to go in:

http://patchwork.ozlabs.org/patch/518321/
http://patchwork.ozlabs.org/patch/518323/

-Scott
