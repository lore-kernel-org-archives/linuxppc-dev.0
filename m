Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2C6FBDDED7
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 01:39:29 +1000 (EST)
Message-Id: <EDB85B26-0051-4DF4-934E-B83487824AD6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Andy Fleming <afleming@freescale.com>
In-Reply-To: <1209772601-28109-1-git-send-email-afleming@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH v2] powerpc: Add 8568 PHY workarounds to board code
Date: Mon, 12 May 2008 10:39:22 -0500
References: <1209772601-28109-1-git-send-email-afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 2, 2008, at 6:56 PM, Andy Fleming wrote:

> The 8568 MDS needs some configuration changes to the PHY in order to
> work properly.  These are done in the firmware, normally, but Linux
> shouldn't need to rely on the firmware running such things (someone
> could disable the PHY support in the firmware to save space, for  
> instance).
>
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> ---
> arch/powerpc/platforms/85xx/mpc85xx_mds.c |  119 ++++++++++++++++++++ 
> +++++++++
> 1 files changed, 119 insertions(+), 0 deletions(-)

applied.

- k
