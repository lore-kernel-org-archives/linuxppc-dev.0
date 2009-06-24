Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E65AAB7096
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Jun 2009 05:15:20 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4FCC4DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2009 05:15:19 +1000 (EST)
Message-Id: <B40B03DC-6064-45A3-A1E5-283F16769FFE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Dan Williams <dan.j.williams@intel.com>
In-Reply-To: <4A4268B7.8060106@intel.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH v3 2/2] fsldma: Add DMA_SLAVE support
Date: Wed, 24 Jun 2009 14:13:00 -0500
References: <20090619193134.GC30992@ovro.caltech.edu>
	<1245705647.937.2.camel@dwillia2-linux.ch.intel.com>
	<2a27d3730906230318g7103a890ic85d1678425ac2c9@mail.gmail.com>
	<6A70F385-C883-4D89-A302-AB09660762C1@kernel.crashing.org>
	<4A40FB26.8080301@intel.com> <4A4268B7.8060106@intel.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Li Yang <leoli@freescale.com>, Ira Snyder <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 24, 2009, at 12:56 PM, Dan Williams wrote:

> Dan Williams wrote:
>> Kumar Gala wrote:
>>>>> Kumar, Leo,
>>>>>
>>>>> Can I get your acked-by's for the current state of async_tx.git/  
>>>>> next?  I
>>>>> just pushed out Ira's latest so it may take a moment to mirror  
>>>>> out.
>>>> Acked-by: Li Yang <leoli@freescale.com>
>>>>
>>>> However, the addition of arch/powerpc/include/asm/fsldma.h still  
>>>> needs
>>>> the ack from Kumar.  It doesn't seem to be a common practice  
>>>> though.
>>> hmm, why are we moving fsldma.h?
>> There are now two fsldma.h files.
>> drivers/dma/fsldma.h: no changes, houses the private driver  
>> implementation details.
>> arch/powerpc/include/asm/fsldma.h: adds some helper routines and  
>> definitions for the DMA_SLAVE capability of the driver.  It defines  
>> an interface for other drivers to use fsldma to initiate device-to- 
>> memory dma.  Any drivers that use the interface will depend on  
>> CONFIG_FSL_DMA hence placing this public header under arch/powerpc/ 
>> include.
>
> Kumar?  Shall we push this decision off to 2.6.32, I would prefer  
> not to as Ira had his initial patches available before the merge  
> window opened?
>
> Ira, aside from the pci read multiple patch are there any others  
> that are suitable for 2.6.31 if the dma_slave implementation gets  
> held back?

Lets go ahead w/2.6.31 (if its ok w/you).

- k
