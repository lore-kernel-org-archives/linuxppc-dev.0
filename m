Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjrsS0YmbzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 13:45:00 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, sam.bobroff@au1.ibm.com
Subject: Re: [PATCH] powernv: Properly mask POWER9 DD1 PVR for different chip
 types
In-Reply-To: <1496882650.31524.14.camel@neuling.org>
References: <20170607041145.3581-1-mikey@neuling.org>
 <87efuwp8ef.fsf@concordia.ellerman.id.au>
 <1496882650.31524.14.camel@neuling.org>
Date: Thu, 08 Jun 2017 13:44:59 +1000
Message-ID: <87poefdtxg.fsf@concordia.ellerman.id.au>
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

Michael Neuling <mikey@neuling.org> writes:

> On Wed, 2017-06-07 at 17:24 +1000, Michael Ellerman wrote:
>> Michael Neuling <mikey@neuling.org> writes:
>>=20
>> > Bits 48:51 in the PVR for POWER9 represent different chip types (scale
>> > up vs out and 12 vs 24 core). Current chips have 0 here, but could be
>> > non-zero in the future.
>> >=20
>> > This changes the POWER9 DD1 mask to correctly ignore these bits 48:51.
>> >=20
>> > Signed-off-by: Michael Neuling <mikey@neuling.org>
>> > ---
>> > =C2=A0arch/powerpc/kernel/cputable.c | 4 ++--
>> > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> Presumably we should backport this?
>
> Actually, we need to scrap this patch.
>
> Looks like the scale up version will be marked as DD1, but it won't need =
these
> workarounds. So we need it to match on the other POWER9 entry.

OK.

/giphy "dumpster fire"

cheers
