Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8Jnr57H5zDqQb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 14:58:40 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christian Kujau <lists@nerdbynature.de>, linuxppc-dev@lists.ozlabs.org
Subject: Re: 4.8.0-rc1: Invalid memory access at $SRR0: 0140f86c $SRR1:
 00003030
In-Reply-To: <1470743530.3015.38.camel@kernel.crashing.org>
References: <alpine.DEB.2.20.14.1608082213450.8131@trent.utfs.org>
 <alpine.DEB.2.20.14.1608090157090.8131@trent.utfs.org>
 <1470743530.3015.38.camel@kernel.crashing.org>
Date: Wed, 10 Aug 2016 14:58:40 +1000
Message-ID: <87inv9te2n.fsf@concordia.ellerman.id.au>
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Tue, 2016-08-09 at 02:06 -0700, Christian Kujau wrote:
>> On Mon, 8 Aug 2016, Christian Kujau wrote:
>> >=20
>> > while trying to upgrade this PowerBook G4 from 4.7-rc7 to 4.8-rc1,
>> > it's=C2=A0
>> > unable to boot the Yaboot (v1.3.16 from Debian/stable) boot loader:
>
> There should already be a fix for that:
>
> http://patchwork.ozlabs.org/patch/654560/
>
> It should be in Michael's tree if not already in Linus.

That fix is in rc1, so this must be a different bug.

cheers
