Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C1F27DF26F
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 00:57:44 +1000 (EST)
Message-Id: <FC8BD7E0-1C94-44AA-A7FB-481CB140D491@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <a267e81e741560d8715ca4422179dcfe2ec467c6.1208364243.git.paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 2/2] mpc86xx_hpcn: Temporarily accept old dts node
	identifier.
Date: Thu, 17 Apr 2008 09:57:40 -0500
References: <80CCBF8C-FE21-4DD7-B1CF-0647D31655D9@kernel.crashing.org>
	<ebd47a82600724a6a80f7fd6efacab22e778858d.1208364243.git.paul.gortmaker@windriver.com>
	<a267e81e741560d8715ca4422179dcfe2ec467c6.1208364243.git.paul.gortmaker@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 16, 2008, at 12:53 PM, Paul Gortmaker wrote:
> As suggested by Timur Tabi, we match on the old compat node ID for one
> version and warn accordingly.  If we don't do this, we plunge people  
> who
> try to use an old DTB into silent boot death with no clear  
> indication of
> what the problem is.
>
> This patch should be removed at the beginning of the 2.6.27 dev cycle.
> It is only meant to ease the transition in the short term.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    6 ++++++
> 1 files changed, 6 insertions(+), 0 deletions(-)

applied.

- k
