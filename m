Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 248EDDE8A0
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 23:06:07 +1000 (EST)
Message-Id: <EE9B1998-B349-462F-98A8-ECC47E4F9357@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jason Jin <Jason.jin@freescale.com>
In-Reply-To: <1211531568-31402-3-git-send-email-Jason.jin@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 3/4 V5] Enable MSI support for MPC8610HPCD board
Date: Fri, 23 May 2008 08:05:58 -0500
References: <1211531568-31402-1-git-send-email-Jason.jin@freescale.com>
	<1211531568-31402-2-git-send-email-Jason.jin@freescale.com>
	<1211531568-31402-3-git-send-email-Jason.jin@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 23, 2008, at 3:32 AM, Jason Jin wrote:

> This patch enable the MSI on 8610hpcd board.
> Through the msi-available-ranges property, All the 256
> msi interrupts can be tested on this board.
>
> Signed-off-by: Jason Jin <Jason.jin@freescale.com>

applied.

- k
