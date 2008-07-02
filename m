Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B31EEDE07D
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 17:42:00 +1000 (EST)
Message-Id: <58163CFC-A697-4FF7-ADC5-A1B9C976965E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
In-Reply-To: <200807011049.32699.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: Commits added to powerpc.git master and powerpc-next branches
Date: Wed, 2 Jul 2008 02:41:44 -0500
References: <18537.30774.608486.268257@cargo.ozlabs.ibm.com>
	<200807011049.32699.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 1, 2008, at 3:49 AM, Laurent Pinchart wrote:

> Hi Paul,
>
> On Tuesday 01 July 2008, Paul Mackerras wrote:
>> The following commits have been added to the master and powerpc-next
>> branches of the powerpc.git repository.  This includes patches pulled
>> from Kumar's and Josh's trees.
>
> Any change of getting the following patches into 2.6.27 ? They have  
> either been acked and not picked, or just ignored so far :-/
>
> [PATCHv2] fs_enet: restore promiscuous and multicast settings in  
> restart()
> 	http://patchwork.ozlabs.org/linuxppc/patch?person=968&id=19228

Should go via netdev unless jgarizk says otherwise

> [PATCH 2/2] fs_enet: MDIO on GPIO support
> 	http://patchwork.ozlabs.org/linuxppc/patch?person=968&id=18693

ditto

> [PATCHv3 1/2] [POWERPC] CPM2: Implement GPIO LIB API on CPM2  
> Freescale SoC.
> 	http://patchwork.ozlabs.org/linuxppc/patch?person=968&id=19045

I'll look at this one

> [PATCH] powerpc: Modem control lines support for the cpm_uart driver
> 	http://patchwork.ozlabs.org/linuxppc/patch?person=968&id=17928

this seems to depend on the previous patch.

> [PATCH] cpm_uart: Support uart_wait_until_sent()
> 	http://patchwork.ozlabs.org/linuxppc/patch?person=968&id=19233


applied

- k
