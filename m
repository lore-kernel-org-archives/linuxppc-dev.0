Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EBEA2DDD04
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jun 2009 20:32:43 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n52AWbeS005116
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Jun 2009 05:32:39 -0500
Subject: Re: [PATCH 2/5] powerpc: Split exception handling out of head_64.S
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <20090602075021.6694CDDFC1@ozlabs.org>
References: <20090602075021.6694CDDFC1@ozlabs.org>
Content-Type: text/plain
Date: Tue, 02 Jun 2009 20:32:36 +1000
Message-Id: <1243938756.5308.44.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-06-02 at 17:50 +1000, Benjamin Herrenschmidt wrote:

> +#ifdef CONFIG_PPC_BOOK3S
> +#include "exceptions-64s.S"
>  #endif

Patches are in the wrong order ... the symbol above is only
define by patch 3/5 :-)

I'll flip the around before mering if there's no other comment.

Cheers,
Ben.
