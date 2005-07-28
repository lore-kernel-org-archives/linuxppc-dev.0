Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 14D4C67D72
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jul 2005 17:08:25 +1000 (EST)
Message-ID: <42E87B2F.30705@intracom.gr>
Date: Thu, 28 Jul 2005 09:29:03 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: "'Aristeu Sergio Rozanski Filho'" <aris@cathedrallabs.org>
References: <855be1bf81cc3629e58e6a23ebb50300@embeddededge.com>	<CBF42A67-D022-4218-8624-8E40400F7C0D@freescale.com>	<20050726100500.GB28003@dmt.cnet>
	<20050727214600.GB30557@cathedrallabs.org>
In-Reply-To: <20050727214600.GB30557@cathedrallabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: platform/board removal update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

'Aristeu Sergio Rozanski Filho' wrote:
>>8xx_io/fec.c is still using v2.4's workqueue infrastructure but other than
>>that its working fine. 
>>
>>The fix will be pushed upstream ASAP.
>>
>>BTW, we should schedule 8xx_io/fec.c for removal, but before that we ought to 
>>test all supported PHY's on the new driver.
>>
>>Aris was talking to me about this on OLS. Aris, what are the PHY's not supported
>>by Panto's driver again? We should build a list of those and ask around for
>>testers.
> 
> I think that with Andy Fleming's PHY abstraction layer, the best thing to be done
> is change fec_8xx to use this abstraction layer and then look for
> testers. what you think?
> 

There's a fs_enet driver in the works which will use Andy's work.

Please refrain from doing anything :)

Regards

Pantelis
