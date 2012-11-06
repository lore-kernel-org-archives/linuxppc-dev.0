Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0D1F62C00C2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2012 22:48:58 +1100 (EST)
Message-ID: <1352202531.2566.40.camel@pasglop>
Subject: Re: RFC: book3e: DCR MMIO for IBM Blue Gene/Q
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jimi Xenidis <jimix@pobox.com>
Date: Tue, 06 Nov 2012 22:48:51 +1100
In-Reply-To: <749146C7-B9A8-4001-9580-3B87A041A580@pobox.com>
References: <020B0706-E2BD-4A6C-8644-D235278655ED@pobox.com>
 <1352073062.12271.268.camel@pasglop>
 <BDD4B115-9D17-4063-A957-65775AEBD0F3@pobox.com>
 <749146C7-B9A8-4001-9580-3B87A041A580@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-11-05 at 09:25 -0600, Jimi Xenidis wrote:
> So Axon, being 64-bit, would break with the changes proposed, since it
> is 64-bit bit and assumes 32bit accessors.
> I'll simply add 64bit accessors for now.

Well, either that, or you add a "64-bit" property to the DCR controller
node. IE. you keep the API "unsigned long" but whether it uses 32 or
64-bit accessors depends on that property.

Cheers,
Ben.
