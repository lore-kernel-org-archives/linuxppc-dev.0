Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 32E382C009A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 19:29:38 +1000 (EST)
Message-ID: <1372930164.4122.95.camel@pasglop>
Subject: Re: [PATCH] Emulate sync instruction variants
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Laight <David.Laight@ACULAB.COM>
Date: Thu, 04 Jul 2013 19:29:24 +1000
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B72CA@saturn3.aculab.com>
References: <1372886807-12109-1-git-send-email-James.Yang@freescale.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B72CA@saturn3.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: James.Yang@freescale.com, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-07-04 at 09:31 +0100, David Laight wrote:
> Do you need to execute 'sync' here?
> It is worth checking whether the trap entry/exit doesn't
> do an implicit one for you.

Not really. It does an implicit isync (more than one even) but
not a sync.

Cheers,
Ben.
