Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0251.outbound.messaging.microsoft.com [213.199.154.251])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B7B572C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Oct 2013 08:52:50 +1100 (EST)
Message-ID: <1381269153.7979.281.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/powernv: Reduce panic timeout from 180s to 10s
From: Scott Wood <scottwood@freescale.com>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 8 Oct 2013 16:52:33 -0500
In-Reply-To: <20131001083918.GD27484@concordia>
References: <20130926211719.7b99740a@kryten> <20131001083918.GD27484@concordia>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-10-01 at 18:39 +1000, Michael Ellerman wrote:
> On Thu, Sep 26, 2013 at 09:17:19PM +1000, Anton Blanchard wrote:
> > 
> > We made this change to pseries in 2011 and I think it makes
> > sense to do the same on powernv.
> 
> I'd vote we set it to 10s for all 64-bit machines in
> arch/powerpc/kernel/setup_64.c.

Why is 64-bit relevant?  And wouldn't such a short delay be a problem if
the crash is displayed on a monitor?

-Scott
