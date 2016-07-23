Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rxLmF6chpzDqTj
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jul 2016 18:49:17 +1000 (AEST)
Message-ID: <1469263746.8568.185.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/64: implement a slice mask cache
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>, Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
Date: Sat, 23 Jul 2016 18:49:06 +1000
In-Reply-To: <20160723171036.67144c5d@roar.ozlabs.ibm.com>
References: <1469192248-25141-1-git-send-email-npiggin@gmail.com>
 <20160723021937.GA13796@350D> <20160723171036.67144c5d@roar.ozlabs.ibm.com>
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

On Sat, 2016-07-23 at 17:10 +1000, Nicholas Piggin wrote:
> I wanted to avoid doing more work under slice_convert_lock, but
> we should just make that a per-mm lock anyway shouldn't we?

Aren't the readers under the mm sem taken for writing or has this
changed ?

Cheers,
Ben.
