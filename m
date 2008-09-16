Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EA3BEDE5F2
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Sep 2008 01:18:33 +1000 (EST)
Message-Id: <827BB86C-A3F1-4B73-8571-4FB1A3517468@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <20080916095747.9992.18412.stgit@ubuntu8041.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH v5 1/2] powerpc: Board support for GE Fanuc SBC610
Date: Tue, 16 Sep 2008 10:18:16 -0500
References: <20080916095741.9992.96106.stgit@ubuntu8041.localdomain>
	<20080916095747.9992.18412.stgit@ubuntu8041.localdomain>
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 16, 2008, at 4:57 AM, Martyn Welch wrote:

> Support for the SBC610 VPX Single Board Computer from GE Fanuc  
> (PowerPC
> MPC8641D).
>
> This is the basic board support for GE Fanuc's SBC610, a 6U single  
> board
> computer, based on Freescale's MPC8641D.
>
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> ---
>
> arch/powerpc/boot/dts/gef_sbc610.dts     |  260 +++++++++++++++++++++ 
> +++++++++
> arch/powerpc/platforms/86xx/Kconfig      |    9 +
> arch/powerpc/platforms/86xx/Makefile     |    1
> arch/powerpc/platforms/86xx/gef_sbc610.c |  149 +++++++++++++++++
> 4 files changed, 418 insertions(+), 1 deletions(-)

applied to powerpc-next.
