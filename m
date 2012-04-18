Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B9235B703E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2012 20:35:50 +1000 (EST)
Message-ID: <1334745338.3143.3.camel@pasglop>
Subject: Re: PowerPC radeon KMS - is it possible?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Date: Wed, 18 Apr 2012 20:35:38 +1000
In-Reply-To: <m2pqb5bhyo.fsf@igel.home>
References: <BAY163-W54EBB2437ED2068EF5AF5D03F0@phx.gbl>
 <1334732346.1159.5.camel__22339.9641145535$1334732429$gmane$org@pasglop>
 <m2pqb5bhyo.fsf@igel.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: o jordan <ojordan12345@hotmail.co.uk>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-04-18 at 09:46 +0200, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > Note also that KMS doesn't afaik have the power management code that
> > radeonfb has for those old Mac chipsets, so suspend/resume won't work.
> 
> How hard would it be to add it?

The code itself is relatively self contained, but the KMS power
management side is a bit ... messy :-) So the real deal is to figure out
how best to "hook it up" there.

There's some duplication 
Cheers,
Ben.
