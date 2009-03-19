Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 81BABDE576
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 20:02:32 +1100 (EST)
Message-Id: <050058C2-20A4-4629-921E-DF149ECC1A6C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20090319041752.8666.46540.stgit@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc/cpm2: fix building fs_enet driver as a module.
Date: Thu, 19 Mar 2009 04:02:27 -0500
References: <20090319041752.8666.46540.stgit@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 18, 2009, at 11:21 PM, Grant Likely wrote:

> From: Grant Likely <grant.likely@secretlab.ca>
>
> Building the fs_enet driver as a modules fails because it cannot
> access the global cpm2_immr symbol.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
> Hey Ben and Kumar,
>
> Just found this while testing some unrelated changes.  Technically
> this is a bug fix that should go into 2.6.29, but it looks like an
> old problem and probably nobody is getting bitten by it.  I don't
> think the world is going to end if it misses the 2.6.29 release.
>
> g.
>
> arch/powerpc/sysdev/cpm2.c |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)

applied to next.  (I agree this isn't worth .29 at this point, if  
anyone cares they can lobby for it in .29.1)

- k
