Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 84D25DDE1F
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 15:06:41 +1100 (EST)
Message-ID: <47DF3FC7.6070500@garzik.org>
Date: Tue, 18 Mar 2008 00:06:31 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH] net: NEWEMAC: Support for Pause packets in EMAC driver
References: <1205488348-22536-1-git-send-email-sr@denx.de>	
	<47DE5F43.80604@garzik.org> <1205789101.26869.181.camel@pasglop>	
	<1205789205.26869.184.camel@pasglop>	
	<20080317164341.12075616@zod.rchland.ibm.com>	
	<1205790747.26869.187.camel@pasglop> <47DEF159.3020504@garzik.org>	
	<20080317200855.2954971a@zod.rchland.ibm.com>
	<1205808100.26869.204.camel@pasglop>
In-Reply-To: <1205808100.26869.204.camel@pasglop>
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
>> http://marc.info/?l=linux-netdev&m=120449748701492&w=2
>>
>> I sent it to Ben with netdev on CC because you asked the various people
>> sending NEWEMAC patches to you to find a single person.
>>
>> So from now on, what are we going to do?  It seems we're playing net
>> maintainer russian roulette for NEWEMAC and it's getting old.
> 
> I'm happy to collect the patches. I said I would do it, I was just taken
> aback a bit by Jeff suddenly merging two of Stefan patches directly :-)

Sorry...  they were CC'd to me and netdev, Stefan had previously 
contributed acceptable patches, and the patches looked OK, so...  :)
