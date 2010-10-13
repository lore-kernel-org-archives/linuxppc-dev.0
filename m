Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 05007B70CD
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Oct 2010 23:38:36 +1100 (EST)
Subject: Re: [PATCH v2] powerpc/fsl-booke: Add support for FSL 64-bit e5500
	core
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20101012151138.62d9e14a@udp111988uds.am.freescale.net>
Date: Wed, 13 Oct 2010 07:38:26 -0500
Message-Id: <066CC4C1-80F7-4600-8AFC-37DB289DF31B@kernel.crashing.org>
References: <1286898653-2266-1-git-send-email-galak@kernel.crashing.org>
	<20101012123308.57a59830@udp111988uds.am.freescale.net>
	<18871C00-4776-46FA-8895-DD0BF261011F@kernel.crashing.org>
	<20101012151138.62d9e14a@udp111988uds.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 12, 2010, at 3:11 PM, Scott Wood wrote:

> On Tue, 12 Oct 2010 14:55:42 -0500
> Kumar Gala <galak@kernel.crashing.org> wrote:
>=20
>>=20
>> On Oct 12, 2010, at 12:33 PM, Scott Wood wrote:
>>=20
>>> On Tue, 12 Oct 2010 10:50:52 -0500
>>> Kumar Gala <galak@kernel.crashing.org> wrote:
>>>=20
>>>> The new e5500 core is similar to the e500mc core but adds 64-bit
>>>> support.  We support running it in 32-bit mode as it is identical =
to the
>>>> e500mc.
>>>>=20
>>>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>>>> ---
>>>> * Updated to remove CONFIG_PPC_E5500 and use E500MC
>>>=20
>>> It still has E500 || E500MC all over the place...
>>>=20
>>> If E500MC is not going to imply E500 that should be consistent for =
both
>>> 32 and 64 bit -- though I think it would make more sense that E500MC
>>> does imply E500.
>>>=20
>>> -Scott
>>=20
>> I have a problem with Kconfig and getting E500MC option to only exist =
in the proper cases.
>=20
> Does having P5020DS (and any future 64-bit-capable board)
> explicitly select E500 as well as PPC_E500MC avoid the issue?

it does, kinda ugly but oh well.

- k
