Return-Path: <dan.j.williams@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by ozlabs.org (Postfix) with ESMTP id C77E9DE2BB
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 17:27:40 +1100 (EST)
Message-ID: <496ED504.5040403@intel.com>
Date: Wed, 14 Jan 2009 23:17:40 -0700
From: Dan Williams <dan.j.williams@intel.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] fsldma: print correct IRQ on mpc83xx
References: <1231944284-18296-1-git-send-email-jacmet@sunsite.dk>	<496E0E85.7060801@freescale.com>
	<87iqohc19b.fsf@macbook.be.48ers.dk>	<496E1317.9070804@freescale.com>
	<87eiz5c074.fsf@macbook.be.48ers.dk>	<496E15E8.2060106@freescale.com>
	<87ab9tbsac.fsf@macbook.be.48ers.dk>
	<496E3D5D.5060701@freescale.com>
In-Reply-To: <496E3D5D.5060701@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: leoli@freescale.com, zw@zh-kernel.org,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Peter Korsgaard wrote:
> 
>> The only minor issues we have is the cosmetic problem of the driver
>> printing NO_IRQ (E.G. this patch), and the driver calling
>> free_irq(NO_IRQ) (E.G. the other patch I sent today) in the release
>> path.
> 
> Ok, I understand.
> 
> ACK on the patches.
> 

Ok, Li Yang and Zhang Wei have been silent recently on fsldma patches. 
Applied to async_tx.git/fixes

Thanks,
Dan
