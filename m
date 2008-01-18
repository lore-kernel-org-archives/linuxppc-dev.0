Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AF6F7DDE30
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 17:37:24 +1100 (EST)
Message-Id: <EA71ABC4-CD55-45A4-B488-081937A211C2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <1199776726-22963-1-git-send-email-leoli@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 2/3 v2] add MPC837x USB platform support
Date: Fri, 18 Jan 2008 00:37:06 -0600
References: <1199776726-22963-1-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 8, 2008, at 1:18 AM, Li Yang wrote:

> Add chip specific and board specific initialization for MPC837x USB.
>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/platforms/83xx/mpc837x_mds.c |   51 ++++++++++++++++++++ 
> +++++++++
> arch/powerpc/platforms/83xx/mpc83xx.h     |    3 ++
> arch/powerpc/platforms/83xx/usb.c         |   40 ++++++++++++++++++++ 
> ++
> 3 files changed, 94 insertions(+), 0 deletions(-)

applied.

- k
