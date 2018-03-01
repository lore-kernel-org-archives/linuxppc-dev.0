Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zsY131cD2zF1cM
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Mar 2018 00:19:03 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [RFC PATCH 1/6] powerpc: Add security feature flags for
 Spectre/Meltdown
In-Reply-To: <20180228150427.GA21977@gate.crashing.org>
References: <20180228145316.11347-1-mpe@ellerman.id.au>
 <20180228150427.GA21977@gate.crashing.org>
Date: Fri, 02 Mar 2018 00:19:02 +1100
Message-ID: <874lm07x2x.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Segher Boessenkool <segher@kernel.crashing.org> writes:

> Hi!
>
> On Thu, Mar 01, 2018 at 01:53:11AM +1100, Michael Ellerman wrote:
>> +// A speculation barrier should be used for bounds checks (Spectre variant 1ull
>
> s/1ull/1)/  ?

Haha, oops. Thanks for spotting it.

Result of replacing ASM_CONST(x) with xull.

cheers
