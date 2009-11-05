Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 42C0AB7BC8
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 00:30:39 +1100 (EST)
Subject: Re: [PATCH] powerpc/85xx: Fix USB GPIOs for MPC8569E-MDS boards
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20091016165013.GA13836@oksana.dev.rtsoft.ru>
Date: Thu, 5 Nov 2009 07:30:34 -0600
Message-Id: <65461468-56EF-4B5B-BB61-B060AAE46F57@kernel.crashing.org>
References: <20091016165013.GA13836@oksana.dev.rtsoft.ru>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, Liu Yu <Yu.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 16, 2009, at 11:50 AM, Anton Vorontsov wrote:

> This patch fixes USB GPIOs numbers for MPC8569E-MDS boards, plus
> according to the latest HW Getting Started Guide (rev 3.3, pilot
> boards), USB "POWER" GPIO polarity has changed, it is no longer
> inverted.
>
> This patch makes USB Host somewhat work on pilot boards, though
> there are still some problems with determining devices speed and
> long bulk transfers.
>
> Reported-by: Liu Yu <Yu.Liu@freescale.com>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc8569mds.dts |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)

applied to merge

- k
