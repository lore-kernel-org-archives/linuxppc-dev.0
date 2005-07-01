Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E28A967C00
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Jul 2005 07:50:02 +1000 (EST)
In-Reply-To: <004001c57e47$5cae9410$0301a8c0@chuck2>
References: <42C40BD0.8040408@anagramm.de><658739DB-540F-4AFC-80DC-BBF0C2AD70F4@freescale.com><42C4162E.4030602@anagramm.de><427c70958bb995dad4fbad2e6ff121bc@embeddededge.com><42C4F50D.3050405@anagramm.de>
	<d946affc11510f7116710026d2a8d1f3@embeddededge.com>
	<004001c57e47$5cae9410$0301a8c0@chuck2>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d67d2bddad7bf2be742b8d53768482bf@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 1 Jul 2005 17:49:52 -0400
To: "Mark Chambers" <markc@mail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC85xx DMA support for Kernel 2.6?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jul 1, 2005, at 10:15 AM, Mark Chambers wrote:

> Is the SRAM being cached?  I don't think the CPU will generate bursts
> unless it's cached, right?

I don't really remember :-)  I know the 8xx will not burst if the line 
isn't
cached, and I know the 7xxx will.  I thought the 82xx and 85xx would
also burst if you had sufficient sequential operations queued.  On
83/85xx you have to further qualify the discussion based upon the DDR2
or the local bus interface :-)  The CPM and DMA will burst on all
buses for 8xx/82xx/83xx/85xx if the memory controller is configured
to do so.

I always end up writing code to test it, then those brain cells get
replaced by more meaningful experiences before I have to use
them again :-)

Thanks.


	-- Dan
