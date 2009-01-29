Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CC84CDDFDD
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jan 2009 16:06:41 +1100 (EST)
Message-Id: <7B73F1BD-8FF5-46CE-9D15-E1589BD70E48@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <20090119113251.9225.2773.stgit@ubuntu8041.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 1/3] powerpc/86xx: Default configutation for GE Fanuc's
	SBC310
Date: Wed, 28 Jan 2009 23:06:33 -0600
References: <20090119112130.9225.82681.stgit@ubuntu8041.localdomain>
	<20090119113251.9225.2773.stgit@ubuntu8041.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 19, 2009, at 5:33 AM, Martyn Welch wrote:

> Support for the SBC310 VPX Single Board Computer from GE Fanuc  
> (PowerPC
> MPC8641D).
>
> This is the default config file for GE Fanuc's SBC310, a 3U single  
> board
> computer, based on Freescale's MPC8641D.
>
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> ---
>
> arch/powerpc/configs/86xx/gef_sbc310_defconfig | 1570 +++++++++++++++ 
> +++++++++
> 1 files changed, 1570 insertions(+), 0 deletions(-)

applied to next

- k
