Return-Path: <vitb@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2C107DDFC3
	for <linuxppc-dev@ozlabs.org>; Fri,  9 May 2008 03:25:44 +1000 (EST)
Date: Thu, 8 May 2008 12:25:19 -0500
From: Vitaly Bordug <vitb@gate.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Delete unused fec_8xx net driver
Message-ID: <20080508172519.GA12162@gate.crashing.org>
References: <Pine.LNX.4.64.0805021320360.24806@monty.am.freescale.net>
	<48208790.5090508@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48208790.5090508@pobox.com>
Cc: netdev@vger.kernel.org, jengelh@medozas.de, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 06, 2008 at 12:30:08PM -0400, Jeff Garzik wrote:
> Becky Bruce wrote:
> >This driver has been superseded by fs_enet and is no longer in use.
> >
> >Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
> 
> I cannot make an informed judgement on this.
> 
> ACK, and pass through platform tree, if all platform peeps are happy.

I'll move thins along.

-Vitaly
