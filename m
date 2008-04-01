Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 89FA0DE069
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 12:15:58 +1000 (EST)
Message-Id: <F555823E-5333-4DD3-9816-FAEC5EFD1649@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kim Phillips <kim.phillips@freescale.com>
In-Reply-To: <20080328105133.43eb4fb1.kim.phillips@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 3/3] sata_fsl: reduce compatibility to fsl,pq-sata
Date: Mon, 31 Mar 2008 21:15:48 -0500
References: <20080328105133.43eb4fb1.kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 28, 2008, at 10:51 AM, Kim Phillips wrote:
> as prescribed in Documentation/powerpc/booting-without-of.txt.
>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> Cc: Jeff Garzik <jgarzik@pobox.com>
> ---
> arch/powerpc/boot/dts/mpc8377_mds.dts |    4 ++--
> arch/powerpc/boot/dts/mpc8379_mds.dts |    8 ++++----
> drivers/ata/sata_fsl.c                |    5 +----
> 3 files changed, 7 insertions(+), 10 deletions(-)

applied.

- k
