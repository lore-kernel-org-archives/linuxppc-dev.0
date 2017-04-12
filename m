Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3HLp6vVszDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 07:37:06 +1000 (AEST)
Message-ID: <1492032891.7236.70.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/64s: catch external interrupts going to host in
 POWER9
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Thu, 13 Apr 2017 07:34:51 +1000
In-Reply-To: <20170413001252.250018c4@roar.ozlabs.ibm.com>
References: <20170412131123.17445-1-npiggin@gmail.com>
 <1492004742.7236.58.camel@kernel.crashing.org>
 <20170413001252.250018c4@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-04-13 at 00:12 +1000, Nicholas Piggin wrote:
> Yeah sure that sounds good. How's this then?

I suppose so :-) When I was testing all that I had a "b ." at 0x500 and
0x4500 and I didn't hit them :)
