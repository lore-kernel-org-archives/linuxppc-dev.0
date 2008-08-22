Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 49D6FDEDEE
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 20:58:12 +1000 (EST)
Message-Id: <23669159-8A9C-4264-BFB0-A903CFDD7D8E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <20080822104625.11984.2953.stgit@ubuntu8041.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH v2 2/2] powerpc: Default configuration for GE Fanuc SBC610
Date: Fri, 22 Aug 2008 05:57:51 -0500
References: <20080822104615.11984.93838.stgit@ubuntu8041.localdomain>
	<20080822104625.11984.2953.stgit@ubuntu8041.localdomain>
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 22, 2008, at 5:46 AM, Martyn Welch wrote:

> Support for the SBC610 VPX Single Board Computer from GE Fanuc  
> (PowerPC
> MPC8641D).
>
> This is the default config file for GE Fanuc's SBC610, a 6U single  
> board
> computer, based on Freescale's MPC8641D.
>
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> ---
>
> arch/powerpc/configs/gef_sbc610_defconfig | 1654 ++++++++++++++++++++ 
> +++++++++
> 1 files changed, 1654 insertions(+), 0 deletions(-)

Do you mind putting this under configs/86xx/gef_sbc610_defconfig (I  
know it 86xx/ doesn't exist but we are getting enough boards there to  
make it useful).

- k
