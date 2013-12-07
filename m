Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EEFB32C008F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Dec 2013 20:57:44 +1100 (EST)
Date: Sat, 7 Dec 2013 10:57:40 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v6 14/17] net: can: mscan: adjust to common clock
 support for mpc512x
Message-ID: <20131207105740.3ed4460d@crub>
In-Reply-To: <1385851897-23475-15-git-send-email-gsi@denx.de>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
 <1385851897-23475-15-git-send-email-gsi@denx.de>
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

On Sat, 30 Nov 2013 23:51:34 +0100
Gerhard Sittig <gsi@denx.de> wrote:

> implement a .get_clock() callback for the MPC512x platform which uses
> the common clock infrastructure (eliminating direct access to the clock
> control registers from within the CAN network driver), and provide the
> corresponding .put_clock() callback to release resources after use
> 
> acquire both the clock items for register access ("ipg") as well as for
> wire communication ("can")
> 
> keep the previous implementation of MPC512x support in place during
> migration, this results in a readable diff of the change
> 
> this change is neutral to the MPC5200 platform
> 
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: linux-can@vger.kernel.org
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
>  drivers/net/can/mscan/mpc5xxx_can.c |  179 +++++++++++++++++++++++++++++++++++
>  1 file changed, 179 insertions(+)

applied to next. Thanks!

Anatolij
