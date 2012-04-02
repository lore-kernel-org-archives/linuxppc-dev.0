Return-Path: <kaffeemonster@googlemail.com>
Received: from uhura.skim.hs-owl.de (uhura.skim.hs-owl.de [193.174.118.81])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 15D45B6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Apr 2012 23:03:16 +1000 (EST)
Message-ID: <4F79A37D.5010605@googlemail.com>
Date: Mon, 2 Apr 2012 15:02:53 +0200
From: Jan Seiffert <kaffeemonster@googlemail.com>
MIME-Version: 1.0
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [REGRESSION][PATCH V4 1/3] bpf jit: Make the
 filter.c::__load_pointer helper non-static  for the jits
References: <AE90C24D6B3A694183C094C60CF0A2F6026B6ECE@saturn3.aculab.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B6ECE@saturn3.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Matt Evans <matt@ozlabs.org>, Eric Dumazet <eric.dumazet@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Laight schrieb:
>  
>> The function is renamed to make it a little more clear what it does.
>> It is not added to any .h because it is not for general 
>> consumption, only for bpf internal use (and so by the jits).
> 
> I'd have thought it better to put in into a bfp_internal.h
> (or similar) with a big warning there about the asm users.
> 

Hmmm, OK, where would i put the .h? Right there under ./include/linux/?

> Possibly even worth adding some other defs that the asm
> files will need (if there are any).
> 

There is at least one other define, the lowest negative address range,
but it would be a copy of the same define in filter.h, or i would have
to massage filter.h to make it fit for inclusion by assembly.
So I'm unsure how to proceed.

> 	David
> 

Greetings
	Jan

-- 
An IPv4 address space walks into a bar: "A strong CIDR please. I'm
exhausted."
