Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5AAA3DE582
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 09:21:12 +1000 (EST)
Message-Id: <630C1356-5460-4C3F-9632-F00D89E921B1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <96011ba20ab9319aa866c12e2ff91ad579d26aed.1208296521.git.paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 1/3] powerpc: Add support for Wind River SBC8641D board
Date: Tue, 15 Apr 2008 18:21:07 -0500
References: <1208299292-21937-1-git-send-email-paul.gortmaker@windriver.com>
	<96011ba20ab9319aa866c12e2ff91ad579d26aed.1208296521.git.paul.gortmaker@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 15, 2008, at 5:41 PM, Paul Gortmaker wrote:
> This adds support for the Wind River SBC8641D board, based
> largely on the mpc86xx_hpcn support.  The biggest difference is
> the lack of the Uli and the i8259 cascade, which simplifies things.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> arch/powerpc/platforms/86xx/Kconfig    |    8 ++-
> arch/powerpc/platforms/86xx/Makefile   |    1 +
> arch/powerpc/platforms/86xx/sbc8641d.c |  164 +++++++++++++++++++++++ 
> +++++++++
> 3 files changed, 172 insertions(+), 1 deletions(-)
> create mode 100644 arch/powerpc/platforms/86xx/sbc8641d.c

applied.

- k
