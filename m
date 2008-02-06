Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7F0B1DDE0E
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 17:05:15 +1100 (EST)
Message-Id: <5CA5CE1D-4287-47C8-BE48-B45782FB4ECE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20080204134617.GA10377@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] [POWERPC] qe_lib: fix few fluffy negligences (was: Re:
	[PATCH 1/5] [POWERPC] qe_lib and users: get rid of most
	device_types and model)
Date: Wed, 6 Feb 2008 00:04:59 -0600
References: <20080124151850.GA15190@localhost.localdomain>
	<20080124153959.GA23246@localhost.localdomain>
	<20080205001318.5fbc60fa.sfr@canb.auug.org.au>
	<20080204134617.GA10377@localhost.localdomain>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>
> From: Anton Vorontsov <avorontsov@ru.mvista.com>
> Subject: [POWERPC] qe_lib: fix few fluffy negligences
>
> One is intoduced by me (of_node_put() absence) and another was
> present already (not checking for NULL).
>
> Found by Stephen Rothwell.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/sysdev/qe_lib/qe.c |   10 +++++-----
> 1 files changed, 5 insertions(+), 5 deletions(-)

applied.

- k
