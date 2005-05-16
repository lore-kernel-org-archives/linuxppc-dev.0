Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A774D679F5
	for <linuxppc-dev@ozlabs.org>; Tue, 17 May 2005 07:02:38 +1000 (EST)
In-Reply-To: <428905F8.4030204@mvista.com>
References: <1116222720.5095.86.camel@gaston>	<7d5cfed0ee1edade8050d2c4da94b3f1@freescale.com>	<c58d28ab50872f95d4c4a751d1768513@embeddededge.com>	<1116255938.5095.133.camel@gaston>	<fe487e7a8a89e65cfefd4f5dd39a982d@embeddededge.com>	<1116261725.5095.139.camel@gaston>
	<4288DFCB.2080208@mvista.com> <4288E10A.9030408@mvista.com>
	<2dd506f0a6d4b03e771c0bc9d80735e6@embeddededge.com>
	<428905F8.4030204@mvista.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <751dc096bc613d131421683f6ba4c68a@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Mon, 16 May 2005 17:02:27 -0400
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: linuxppc-dev@ozlabs.org, John Reiser <jreiser@BitWagon.com>
Subject: Re: 2GB address space limit on 32-bit PowerPC Macintosh
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 16, 2005, at 4:43 PM, Mark A. Greer wrote:

> I think I understand all of that.  I wasn't clear in my email.  I was 
> talking about "fixing" such that 3GB works (i.e., io_block_mapping are 
> above 3GB virt, if possible) not "fixing" such that we can get rid of 
> io_block_mapping altogether.  We still need io_block_mapping for 
> exactly the reasons you state.

I think I've seen hacks from you that temporarily set up BATs for 
serial console
access until the BAT is forcefully re-used later :-)  I just wanted to 
document the
issue for everyone, that breaking this is more than just a five minute 
fix and
test exercise (which may only further obfuscate a hack than actually 
change
anything) :-)

Thanks.

	-- Dan
