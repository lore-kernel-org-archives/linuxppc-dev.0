Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVGNH4TTNzDqnd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 15:13:51 +1100 (AEDT)
In-Reply-To: <20180124014228.GA26899@embeddedgus>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Colin Leroy <colin@colino.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: macintosh: change some data types from int to bool
Message-Id: <3zVGNG6B8Hz9t5Y@ozlabs.org>
Date: Mon, 29 Jan 2018 15:13:50 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-01-24 at 01:42:28 UTC, "Gustavo A. R. Silva" wrote:
> Change the data type of the following variables from int to bool
> across all macintosh drivers:
> 
> started
> slots_started
> pm121_started
> wf_smu_started
> 
> Some of these issues were detected with the help of Coccinelle.
> 
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4f256d561447c6e1bf8b70e19daae0

cheers
