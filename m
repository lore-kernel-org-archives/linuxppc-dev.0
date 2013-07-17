Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7B9AA2C0137
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jul 2013 10:04:20 +1000 (EST)
Message-ID: <1374019445.19894.403.camel@pasglop>
Subject: Re: [PATCH] module: ppc64 module CRC relocation fix causes perf issues
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Wed, 17 Jul 2013 10:04:05 +1000
In-Reply-To: <1374014420.8183.342@snotra>
References: <1374014420.8183.342@snotra>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Neil Horman <nhorman@tuxdriver.com>, Rusty Russell <rusty@rustcorp.com.au>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-07-16 at 17:40 -0500, Scott Wood wrote:
> On 07/15/2013 03:47:06 AM, Benjamin Herrenschmidt wrote:
> > On Mon, 2013-07-15 at 14:04 +1000, Anton Blanchard wrote:
> > > Module CRCs are implemented as absolute symbols that get resolved by
> > > a linker script. We build an intermediate .o that contains an
> > > unresolved symbol for each CRC. genksysms parses this .o, calculates
> > > the CRCs and writes a linker script that "resolves" the symbols to
> > > the calc
> > 
> > Scott, can somebody from FSL test that on 32-bit and Ack it ?
> > 
> > Thanks !
> > 
> > Cheers,
> > Ben.
> 
> It boots for me on e500mc and I can insert modules.

But does perf work ? :-)

Cheers,
Ben.
