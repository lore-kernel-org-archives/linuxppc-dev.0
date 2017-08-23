Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xclsB2k8xzDrK0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 21:42:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>, Paul Mackerras <paulus@ozlabs.org>,
 linuxppc-dev@ozlabs.org
Subject: Re: [PATCH RFC 0/7] powerpc: Beef up single-stepping/instruction
 emulation infrastructure
In-Reply-To: <1503480443.25055.22.camel@neuling.org>
References: <1503445683-12011-1-git-send-email-paulus@ozlabs.org>
 <1503480443.25055.22.camel@neuling.org>
Date: Wed, 23 Aug 2017 21:42:21 +1000
Message-ID: <87bmn6y0gy.fsf@concordia.ellerman.id.au>
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

> Paulus,=20
>
>> This patch series extends the code in arch/powerpc/lib/sstep.c so that
>> it handles almost all load and store instructions -- all except the
>> atomic memory operations (lwat, stwat, etc.).=C2=A0=C2=A0It also makes s=
ure that
>> we use the largest possible aligned accesses to access memory and that
>> we don't access the CPU FP/VMX/VSX registers when they don't contain
>> user data.
>
> Do you have any test cases we can put in selftests for this?

We have lots of plans for them, but no code yet.

cheers
