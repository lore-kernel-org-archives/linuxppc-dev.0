Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9EB91DDF12
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Sep 2008 17:19:41 +1000 (EST)
Subject: Re: [PATCH 0/3 v2] ibm_newemac: Various fixes and additions for
	PPC405EZ
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <cover.1220877899.git.jwboyer@linux.vnet.ibm.com>
References: <cover.1220877899.git.jwboyer@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Tue, 09 Sep 2008 17:11:23 +1000
Message-Id: <1220944283.4879.323.camel@pasglop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-09-08 at 08:44 -0400, Josh Boyer wrote:
> The following patch series adds things needed to support the PowerPC 405EZ
> SoC.  I've incorporated the suggestions and fixes from the previous round
> of patches and barring any further comments these should be ready to go.

For some reason, I got this email but not the 3 following patch ones...

Cheers,
Ben.

> josh
> 
> Josh Boyer (3):
>   ibm_newemac: Allow the "no flow control" EMAC feature to work
>   ibm_newemac: Introduce mal_has_feature
>   ibm_newemac: MAL support for PowerPC 405EZ
> 
>  arch/powerpc/include/asm/dcr-regs.h |    7 ++++
>  drivers/net/ibm_newemac/Kconfig     |   12 +++++++
>  drivers/net/ibm_newemac/core.c      |    2 +
>  drivers/net/ibm_newemac/core.h      |    3 ++
>  drivers/net/ibm_newemac/mal.c       |   60 ++++++++++++++++++++++++++++++++---
>  drivers/net/ibm_newemac/mal.h       |   34 ++++++++++++++++++++
>  6 files changed, 113 insertions(+), 5 deletions(-)
