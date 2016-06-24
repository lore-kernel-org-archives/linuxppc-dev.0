Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rbbn00YxhzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 21:33:23 +1000 (AEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id u5OBXI6a012769
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 06:33:19 -0500
Message-ID: <1466767997.11733.96.camel@kernel.crashing.org>
Subject: Re: [RFC/PATCH] powerpc/pci: Don't try to allocate resources that
 will be reassigned
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc dev list <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 24 Jun 2016 21:33:17 +1000
In-Reply-To: <1466580277.4089.25.camel@kernel.crashing.org>
References: <1466580277.4089.25.camel@kernel.crashing.org>
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

On Wed, 2016-06-22 at 17:24 +1000, Benjamin Herrenschmidt wrote:
> When we know we will reassign all resources, trying (and failing)
> to allocate them initially is fairly pointless and leads to a lot
> of scary messages in the kernel log
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> --
> 
> This one probably needs testing on a few platforms but I think it's
> correct ;-)

The patch is crap, it was against one of my trees that has not the
right code in it. I'll post the real one as v2
