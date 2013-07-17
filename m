Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0185.outbound.messaging.microsoft.com [213.199.154.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C26482C0150
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jul 2013 10:08:29 +1000 (EST)
Date: Tue, 16 Jul 2013 19:08:17 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] module: ppc64 module CRC relocation fix causes perf issues
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1374014420.8183.342@snotra> <1374019445.19894.403.camel@pasglop>
In-Reply-To: <1374019445.19894.403.camel@pasglop> (from
 benh@kernel.crashing.org on Tue Jul 16 19:04:05 2013)
Message-ID: <1374019697.8183.351@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
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

On 07/16/2013 07:04:05 PM, Benjamin Herrenschmidt wrote:
> On Tue, 2013-07-16 at 17:40 -0500, Scott Wood wrote:
> > On 07/15/2013 03:47:06 AM, Benjamin Herrenschmidt wrote:
> > > On Mon, 2013-07-15 at 14:04 +1000, Anton Blanchard wrote:
> > > > Module CRCs are implemented as absolute symbols that get =20
> resolved by
> > > > a linker script. We build an intermediate .o that contains an
> > > > unresolved symbol for each CRC. genksysms parses this .o, =20
> calculates
> > > > the CRCs and writes a linker script that "resolves" the symbols =20
> to
> > > > the calc
> > >
> > > Scott, can somebody from FSL test that on 32-bit and Ack it ?
> > >
> > > Thanks !
> > >
> > > Cheers,
> > > Ben.
> >
> > It boots for me on e500mc and I can insert modules.
>=20
> But does perf work ? :-)

What specifically should I do to test it?

-Scott=
