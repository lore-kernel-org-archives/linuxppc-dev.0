Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9AE90B6F69
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Aug 2011 03:48:12 +1000 (EST)
Subject: Re: union/struct representations for MAS Registers
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AE26@saturn3.aculab.com>
Date: Wed, 10 Aug 2011 12:48:05 -0500
Message-Id: <6AC384B9-E07E-4BFC-B9AD-3A671EF4F650@kernel.crashing.org>
References: <AE90C24D6B3A694183C094C60CF0A2F6D8AE26@saturn3.aculab.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: Linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 10, 2011, at 12:38 PM, David Laight wrote:

>=20
>>> Bitfields are rather non-portable, the compiler has a lot of choice
>>> about how to align the bits in memory.
>>=20
>> I'm ok with the masking stuff.
>> However, I'm actually surprised this is true given the=20
>> maturity of our ABIs.
>=20
> The C standard says nothing at all about how bitfields are =
implemented,
> I think the first bit might be 0x1, 0x80, 0x1000000 or 0x80000000
> when treated as a 32bit value, regardless of the endianness.
>=20
> Different architectures can (and do) assign things in different ways.
> So code that is ok on ppc might fail on arm or x86 (etc).
>=20
> 	David

I think PPCs a bit sane and what Jimi was proposing the union for is =
something that would never need to be portable (as it a PPC specific =
register).

Still, prefer the shifts, masks & macros as that's what I've been =
reading & using in ppc land forever ;)

- k=
