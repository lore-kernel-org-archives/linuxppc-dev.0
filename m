Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415Cf86L9TzDrqP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 13:58:24 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 Segher Boessenkool <segher@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, wei.guo.simon@gmail.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 3/4] powerpc/lib: implement strlen() in assembly
In-Reply-To: <baaf4fa9-ff0b-0bcb-8662-dafb794caab4@c-s.fr>
References: <85de16f5629ac9f4a815230cced361908758b53a.1528791416.git.christophe.leroy@c-s.fr>
 <8b89f2e21f7e3a865105eeeeda509243db393454.1528791416.git.christophe.leroy@c-s.fr>
 <20180612145315.GJ27520@gate.crashing.org>
 <baaf4fa9-ff0b-0bcb-8662-dafb794caab4@c-s.fr>
Date: Wed, 13 Jun 2018 13:58:24 +1000
Message-ID: <877en3tk0v.fsf@concordia.ellerman.id.au>
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

Christophe LEROY <christophe.leroy@c-s.fr> writes:

> Le 12/06/2018 =C3=A0 16:53, Segher Boessenkool a =C3=A9crit=C2=A0:
>> On Tue, Jun 12, 2018 at 09:14:53AM +0000, Christophe Leroy wrote:
>>> ---
>>> Not tested on PPC64.
>>=20
>> It won't be acceptable until that happens.  It also is likely quite bad
>> performance on all 64-bit CPUs from the last fifteen years or so.  Or you
>> did nothing to prove otherwise, at least.
>
> Will it be as bad as the generic implementation which does it byte per=20
> byte ?
>
> I don't have any 64 bits target, can someone test it using the test app=20
> I have added in selftests ?

I /can/ but I won't have time this week.

> Or should I just leave it as is for 64 bits and just do the=20
> implementation for 32 bits until someone wants to try and do it for PPC64=
 ?

That's probably best yeah.

cheers
