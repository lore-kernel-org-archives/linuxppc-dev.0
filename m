Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ADC7CDEE30
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 00:57:26 +1000 (EST)
Message-Id: <3D7B198B-E685-424C-A3D9-D9C843004E0F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <ebd47a82600724a6a80f7fd6efacab22e778858d.1208364243.git.paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 1/2] 86xx: mark functions static, other minor cleanups
Date: Thu, 17 Apr 2008 09:57:20 -0500
References: <80CCBF8C-FE21-4DD7-B1CF-0647D31655D9@kernel.crashing.org>
	<ebd47a82600724a6a80f7fd6efacab22e778858d.1208364243.git.paul.gortmaker@windriver.com>
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
> Cleanups as suggested by Stephen Rothwell and Dale Farnsworth, which
> incudes marking a bunch of functions static and add a vendor prefix to
> the compat node check for uniqueness.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> arch/powerpc/boot/dts/mpc8641_hpcn.dts     |    2 +-
> arch/powerpc/platforms/86xx/mpc8610_hpcd.c |    4 ++--
> arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    8 ++++----
> 3 files changed, 7 insertions(+), 7 deletions(-)

applied.

- k
