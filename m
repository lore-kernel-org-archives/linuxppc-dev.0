Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xTw95V4JzDrZD
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2018 00:13:45 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Josef Bacik <jbacik@fb.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc: Add support for function error injection
In-Reply-To: <1527761352.z5jz8jg2d5.naveen@linux.ibm.com>
References: <cover.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
 <5ad23690185a90a887514d702ecb45783090d7c0.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
 <87h8mozajv.fsf@concordia.ellerman.id.au>
 <1527761352.z5jz8jg2d5.naveen@linux.ibm.com>
Date: Fri, 01 Jun 2018 00:13:44 +1000
Message-ID: <87zi0fyktj.fsf@concordia.ellerman.id.au>
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

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:

> Michael Ellerman wrote:
>> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>>> ...
>> 
>> A change log is always nice even if it's short :)
>
> I tried, but really couldn't come up with anything more to write. I'll 
> try harder for v2 :)

Yeah true.

You could just say "All that's required is to define x and y and select
the Kconfig symbol".

>> This looks fine to me, it's probably easiest if it goes in via tip along
>> with patch 1.
>> 
>> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
>
> Thanks for the review. I'll base v2 on -tip

I guess if it doesn't already apply to tip you should rebase it. You've
probably missed 4.18 anyway.

cheers
