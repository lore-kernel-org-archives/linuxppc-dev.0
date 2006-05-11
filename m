Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D3048679F4
	for <linuxppc-dev@ozlabs.org>; Fri, 12 May 2006 09:41:45 +1000 (EST)
In-Reply-To: <20060511002217.GA31481@twiddle.net>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
	<20060510154702.GA28938@twiddle.net>
	<20060510.124003.04457042.davem@davemloft.net>
	<17506.21908.857189.645889@cargo.ozlabs.ibm.com>
	<49BB818F-DF88-43A3-8B6A-7F9F5C7A2C3C@kernel.crashing.org>
	<20060511002217.GA31481@twiddle.net>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E44D1BA0-2DB1-4151-BAC7-16B4BF37E419@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
Date: Fri, 12 May 2006 01:41:32 +0200
To: Richard Henderson <rth@twiddle.net>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, "David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Would an asm clobber of GPR13 in the schedule routines (or a wrapper
>> for them, or whatever) work?
>
> No.  The address is cse'd symbolically long before the r13
> reference is exposed.

Current GCC won't ever do that over a (non-local, non-inlinable)
function call though.  _Current_ GCC.


Segher
