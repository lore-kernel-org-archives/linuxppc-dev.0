Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 08E15DE8D4
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 01:29:42 +1000 (EST)
Message-Id: <F7AFD26F-39FE-4C1F-8918-F799F65F9559@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Robert Schwebel <r.schwebel@pengutronix.de>
In-Reply-To: <20080415152638.GW13814@pengutronix.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: fec_mpc5200: reset FEC on error
Date: Tue, 15 Apr 2008 10:29:26 -0500
References: <20080415152638.GW13814@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, Domen Puncer <domen@coderock.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 15, 2008, at 10:26 AM, Robert Schwebel wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
>
> The error handling for the mpc5200 fec interrupt is broken. The  
> intended
> behaviour is like this:
>
> * If one of FEC_IEVENT_RFIFO_ERROR and FEC_IEVENT_XFIFO_ERROR happens,
>  the datasheet says (MPC5200B User's Guide R1.2, p. 14-13): "When this
>  occurs, software must ensure both the FIFO Controller and BestComm  
> are
>  soft-reset".
>
> * On any other error (non-TFINT) interrupt, just issue a debug  
> message.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>
> ---
> drivers/net/fec_mpc52xx.c |   23 +++++++++++++----------
> 1 file changed, 13 insertions(+), 10 deletions(-)
>

You really need to also copy netdev and patches to drivers/net.

- k
