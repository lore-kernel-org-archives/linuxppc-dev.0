Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 851A4B6EFF
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Apr 2011 22:26:46 +1000 (EST)
Subject: Re: [RFC][PATCH] powerpc/book3e: Fix CPU feature handling on e5500
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20110406154147.f736d92e.sfr@canb.auug.org.au>
Date: Wed, 6 Apr 2011 07:26:00 -0500
Message-Id: <32DBACBF-FCBE-4FBD-BD87-0CA3CD670C10@kernel.crashing.org>
References: <1302067772-32104-1-git-send-email-galak@kernel.crashing.org>
	<20110406154147.f736d92e.sfr@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 6, 2011, at 12:41 AM, Stephen Rothwell wrote:

> Hi Kumar,
>=20
> On Wed,  6 Apr 2011 00:29:32 -0500 Kumar Gala =
<galak@kernel.crashing.org> wrote:
>>=20
>> * I'm concerned if its ok to assume 'enum' can handle a 64-bit mask =
or not.
>>  I'm assuming this is the reason that we use a #define on =
__powerpc64__
>=20
> enums are *ints* and therefore 32 bit.  gcc can cope, but warns about =
it
> (I think). So we must use the #define if any of the included bits are
> above 2^32.

Thanks, I'll rework the patch to use #define.

- k=
