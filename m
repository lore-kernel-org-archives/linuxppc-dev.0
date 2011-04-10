Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F3076B6EFF
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Apr 2011 03:29:20 +1000 (EST)
Subject: Re: [PATCH 2/3] powerpc: Use MSR_64BIT in places
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1302386681.28876.0.camel@pasglop>
Date: Sun, 10 Apr 2011 12:29:03 -0500
Message-Id: <94DD022B-86D8-4751-BB65-7D46AC63ED9A@kernel.crashing.org>
References: <ca7cc2a36bbf492c11cd98d3d1dea0835731c75f.1302249358.git.michael@ellerman.id.au>
	<431bd20fec52ff41fb47808954993ab6369eb45e.1302249358.git.michael@ellerman.id.au>
	<FA53E865-AB9E-4222-A990-F552E1A1C093@kernel.crashing.org>
	<1302386681.28876.0.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 9, 2011, at 5:04 PM, Benjamin Herrenschmidt wrote:

> On Fri, 2011-04-08 at 04:24 -0500, Kumar Gala wrote:
>> On Apr 8, 2011, at 2:56 AM, Michael Ellerman wrote:
>>=20
>>> Use the new MSR_64BIT in a few places. Some of these are already =
ifdef'ed
>>> for BOOKE vs BOOKS, but it's still clearer, MSR_SF does not =
immediately
>>> parse as "MSR bit for 64bit".
>>>=20
>>> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
>>> ---
>>> arch/powerpc/kernel/head_64.S   |    2 +-
>>> arch/powerpc/kernel/signal_64.c |    4 ++--
>>> arch/powerpc/kernel/traps.c     |    2 +-
>>> arch/powerpc/xmon/xmon.c        |   14 +++++++-------
>>> 4 files changed, 11 insertions(+), 11 deletions(-)
>>=20
>> However MSR_ISF does ;)
>=20
> I'm not sure I parse that one :-) Any ways ISF is "interrupt SF" and =
has
> no equivalent in the MSR for BookE (it's elsewhere, EPCR no ?).

I was just saying that if _SF doesn't parse as 64-bit mode, ISF doesn't =
parse as interrupt into 64-bit mode :)

- k=
