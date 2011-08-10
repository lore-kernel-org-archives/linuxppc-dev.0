Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 47B28B6F70
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Aug 2011 03:25:24 +1000 (EST)
Subject: Re: union/struct representations for MAS Registers
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <B952E5AF-98EF-46CE-B30F-7E1EA55C33AC@pobox.com>
Date: Wed, 10 Aug 2011 12:25:14 -0500
Message-Id: <9FE83BDE-592D-42FC-B2B4-A2B6E7E49206@kernel.crashing.org>
References: <B952E5AF-98EF-46CE-B30F-7E1EA55C33AC@pobox.com>
To: Jimi Xenidis <jimix@pobox.com>
Cc: Linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 10, 2011, at 12:21 PM, Jimi Xenidis wrote:

> I have some and use them in some code, they represent ISA 2.06 MAVN=3D1 =
(version 2)
> Can I keep them?
> if so, should I put them somewhere useful to others?
>=20
> Examples:
> union mas1 {
> 	u32 _val;
> 	struct {
> 		u32 v:1;
> 		u32 iprot:1;
> 		u32 tid:14;
> 		u32 _reserved_1:2;
> 		u32 ind:1;
> 		u32 ts:1;
> 		u32 tsize:4;
> 		u32 _reserved_2:8;
> 	};
> };

Uugh, we really have avoided unions for such things and it would be nice =
to keep it that way.

- k=
