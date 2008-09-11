Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 68DCCDDF6E
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 13:21:10 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m8B3L7k0019903
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 23:21:07 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m8B3L78K223804
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 23:21:07 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m8B3L7iE021953
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 23:21:07 -0400
Date: Wed, 10 Sep 2008 23:21:03 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 0/3 v2] ibm_newemac: Various fixes and additions for
	PPC405EZ
Message-ID: <20080910232103.15a9b87e@zod.rchland.ibm.com>
In-Reply-To: <cover.1220877899.git.jwboyer@linux.vnet.ibm.com>
References: <cover.1220877899.git.jwboyer@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: netdev@vger.kernel.org, jeff@garzik.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 8 Sep 2008 08:44:59 -0400
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> The following patch series adds things needed to support the PowerPC 405EZ
> SoC.  I've incorporated the suggestions and fixes from the previous round
> of patches and barring any further comments these should be ready to go.
> 
> josh
> 
> Josh Boyer (3):
>   ibm_newemac: Allow the "no flow control" EMAC feature to work
>   ibm_newemac: Introduce mal_has_feature
>   ibm_newemac: MAL support for PowerPC 405EZ

I should mention that I have a platform support patch series that
depends on these for working ethernet.  I can bring this set in through
my tree at the same time if the patches look fine and Jeff acks that.

josh
