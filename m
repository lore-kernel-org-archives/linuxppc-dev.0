Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 64F8CB7091
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Aug 2011 03:38:54 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP id 30140-05 for <linuxppc-dev@ozlabs.org>;
	Wed, 10 Aug 2011 18:38:52 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: union/struct representations for MAS Registers
Date: Wed, 10 Aug 2011 18:38:54 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AE26@saturn3.aculab.com>
In-Reply-To: <B8DCD489-B158-40BB-87BD-873A3591737F@pobox.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Jimi Xenidis" <jimix@pobox.com>
Cc: Linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> > Bitfields are rather non-portable, the compiler has a lot of choice
> > about how to align the bits in memory.
>=20
> I'm ok with the masking stuff.
> However, I'm actually surprised this is true given the=20
> maturity of our ABIs.

The C standard says nothing at all about how bitfields are implemented,
I think the first bit might be 0x1, 0x80, 0x1000000 or 0x80000000
when treated as a 32bit value, regardless of the endianness.

Different architectures can (and do) assign things in different ways.
So code that is ok on ppc might fail on arm or x86 (etc).

	David
