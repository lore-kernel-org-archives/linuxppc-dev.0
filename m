Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w9VwY3VsbzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Apr 2017 10:39:25 +1000 (AEST)
Message-ID: <1492907951.25766.191.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/64s: use
 ibm,tlbiel-congruence-classes-(hash|radix) dt property
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.vnet.ibm.com>
Date: Sun, 23 Apr 2017 10:39:11 +1000
In-Reply-To: <20170423091428.16fc298f@roar.ozlabs.ibm.com>
References: <20170422005854.17128-1-npiggin@gmail.com>
 <20170422005854.17128-2-npiggin@gmail.com>
 <1492848130.25766.185.camel@kernel.crashing.org>
 <20170423091428.16fc298f@roar.ozlabs.ibm.com>
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

On Sun, 2017-04-23 at 09:14 +1000, Nicholas Piggin wrote:
> I think we were going to take another look at moving the setup code
> later, but I think that might wait until 4.13.

Except without that we won't boot a post-P9 CPU right ? So we'll end up
having to chase distros to backport it :-( Oh well...

Ben.
