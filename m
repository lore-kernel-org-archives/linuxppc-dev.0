Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B6C82DE510
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 09:32:04 +1100 (EST)
Message-ID: <47DEF159.3020504@garzik.org>
Date: Mon, 17 Mar 2008 18:31:53 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH] net: NEWEMAC: Support for Pause packets in EMAC driver
References: <1205488348-22536-1-git-send-email-sr@denx.de>	
	<47DE5F43.80604@garzik.org> <1205789101.26869.181.camel@pasglop>	
	<1205789205.26869.184.camel@pasglop>	
	<20080317164341.12075616@zod.rchland.ibm.com>
	<1205790747.26869.187.camel@pasglop>
In-Reply-To: <1205790747.26869.187.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, Stefan Roese <sr@denx.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>> There's also the section mismatch patch I sent you.  I don't care who's
>> tree they go through, but I'd need to know either way so keep me in the
>> loop please.
> 
> Jeff, do you mind if we get those patches through the powerpc tree ?
> EMAC is very powerpc specific and these are mostly internal driver
> cuisine.

Fine with me in concept, though I haven't seen the patches in question.

	Jeff
