Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F233BDE0C8
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 02:30:13 +1000 (EST)
Message-ID: <48208790.5090508@pobox.com>
Date: Tue, 06 May 2008 12:30:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Becky Bruce <bgill@freescale.com>
Subject: Re: [PATCH] Delete unused fec_8xx net driver
References: <Pine.LNX.4.64.0805021320360.24806@monty.am.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0805021320360.24806@monty.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: scottwood@freescale.com, netdev@vger.kernel.org, jengelh@medozas.de,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Becky Bruce wrote:
> This driver has been superseded by fs_enet and is no longer in use.
> 
> Signed-off-by: Becky Bruce <becky.bruce@freescale.com>

I cannot make an informed judgement on this.

ACK, and pass through platform tree, if all platform peeps are happy.
