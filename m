Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0187.outbound.messaging.microsoft.com [213.199.154.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BA8532C0159
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jul 2013 08:40:35 +1000 (EST)
Date: Tue, 16 Jul 2013 17:40:20 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] module: ppc64 module CRC relocation fix causes perf issues
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1373878026.19894.335.camel@pasglop> (from
 benh@kernel.crashing.org on Mon Jul 15 03:47:06 2013)
Message-ID: <1374014420.8183.342@snotra>
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

On 07/15/2013 03:47:06 AM, Benjamin Herrenschmidt wrote:
> On Mon, 2013-07-15 at 14:04 +1000, Anton Blanchard wrote:
> > Module CRCs are implemented as absolute symbols that get resolved by
> > a linker script. We build an intermediate .o that contains an
> > unresolved symbol for each CRC. genksysms parses this .o, calculates
> > the CRCs and writes a linker script that "resolves" the symbols to
> > the calc
>=20
> Scott, can somebody from FSL test that on 32-bit and Ack it ?
>=20
> Thanks !
>=20
> Cheers,
> Ben.

It boots for me on e500mc and I can insert modules.

-Scott=
