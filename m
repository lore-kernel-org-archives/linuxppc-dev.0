Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tC4kY5fkkzDt1Y
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 19:05:41 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joe Perches <joe@perches.com>, David Miller <davem@davemloft.net>,
 madalin.bucur@nxp.com, Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: pebolle@tiscali.nl, joakim.tjernlund@transmode.se, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ppc@mindchasers.com, oss@buserror.net,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: Coding Style: Reverse XMAS tree declarations ? (was Re: [PATCH
 net-next v6 02/10] dpaa_eth: add support for DPAA Ethernet)
In-Reply-To: <1478242438.1924.31.camel@perches.com>
References: <1478117854-8952-1-git-send-email-madalin.bucur@nxp.com>
 <1478117854-8952-3-git-send-email-madalin.bucur@nxp.com>
 <20161103.155816.642712588084106823.davem@davemloft.net>
 <1478242438.1924.31.camel@perches.com>
Date: Mon, 07 Nov 2016 19:05:40 +1100
Message-ID: <877f8fn297.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joe Perches <joe@perches.com> writes:
> On Thu, 2016-11-03 at 15:58 -0400, David Miller wrote:
>> From: Madalin Bucur <madalin.bucur@nxp.com>
>> Date: Wed, 2 Nov 2016 22:17:26 +0200
>>=20
>> > This introduces the Freescale Data Path Acceleration Architecture
>> > +static inline size_t bpool_buffer_raw_size(u8 index, u8 cnt)
>> > +{
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 i;
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0size_t res =3D DPAA_BP_RAW_SIZE / 2;
>>=20
>> Always order local variable declarations from longest to shortest line,
>> also know as Reverse Christmas Tree Format.
>
> I think this declaration sorting order is misguided but
> here's a possible change to checkpatch adding a test for it
> that does this test just for net/ and drivers/net/

And arch/powerpc too please.

cheers
