Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E45BBB70A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Sep 2010 23:37:51 +1000 (EST)
Subject: Re: how to understand powerpc's BRx ORx
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <201009101356067140460@gmail.com>
Date: Fri, 10 Sep 2010 08:37:42 -0500
Message-Id: <E5728A61-06B2-4E9E-B468-3848633D3DF1@kernel.crashing.org>
References: <201009101356067140460@gmail.com>
To: hacklu <embedway.test@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 10, 2010, at 12:56 AM, hacklu wrote:

> I didn't understand the address mask.
> it's said that: BR[BA] is the base address,the OR[AM] is the  address =
mask,
> "Provides masking for corresponding BRx bits. By masking address=20
> bits independently, SDRAM devices of different size address ranges can =
be used. Clearing=20
> bits masks the corresponding address bit. Setting bits causes the =
corresponding address=20
> bit to be compared with the address pins. Address mask bits can be set =
or cleared in any=20
> order, allowing a resource to reside in more than one area of the =
address map. SDAM can=20
> be read or written at any time."
>=20
> how to understand it?
> for instance, if my BR0[BA]=3D0111_0000_0000_0000_0, =
OR0[AM]=3D1111_1111_1111
> if I want to access the 0x70000000 or the 0x71000001.what address =
calculate will be taken?

Can you let us know which chip you are looking at using?  There is a bit =
of variation so its useful to know.

- k=
