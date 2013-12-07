Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 72E762C0532
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Dec 2013 20:58:10 +1100 (EST)
Date: Sat, 7 Dec 2013 10:58:06 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v6 15/17] net: can: mscan: remove non-CCF code for MPC512x
Message-ID: <20131207105806.58a045b7@crub>
In-Reply-To: <1385851897-23475-16-git-send-email-gsi@denx.de>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
 <1385851897-23475-16-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 30 Nov 2013 23:51:35 +0100
Gerhard Sittig <gsi@denx.de> wrote:

> transition to the common clock framework has completed and the PPC_CLOCK
> is no longer available for the MPC512x platform, remove the now obsolete
> code path of the mpc5xxx mscan driver which accessed clock control module
> registers directly
> 
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: linux-can@vger.kernel.org
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
>  drivers/net/can/mscan/mpc5xxx_can.c |  141 -----------------------------------
>  1 file changed, 141 deletions(-)

applied to next. Thanks!

Anatolij
