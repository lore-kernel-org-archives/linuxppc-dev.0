Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2F995DE106
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 03:15:15 +1100 (EST)
In-Reply-To: <17799.32212.110299.916299@cargo.ozlabs.ibm.com>
References: <11660315492978-git-send-email-timur@freescale.com>
	<17799.32212.110299.916299@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0298A286-221C-4570-A798-05AB9CE8ECD6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Fix phy_read/write redefinition errors in ucc_geth_phy.c
Date: Tue, 19 Dec 2006 10:15:17 -0600
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 18, 2006, at 11:51 PM, Paul Mackerras wrote:

> timur@freescale.com writes:
>
>> The local versions of phy_read() and phy_write() in ucc_geth_phy.c  
>> conflict
>> with the prototypes in include/linux/phy.h, so this patch renames  
>> them,
>> moves them to the top of the file (while eliminating the redundant  
>> prototype),
>> and makes them static.
>
> You really need to send this patch to Jeff Garzik and the netdev
> list.  If the driver won't compile in its current state in Linus' tree
> because of the problem this fixes, make sure you make that point in
> the patch commentary and explicitly ask Jeff to get the patch into
> 2.6.20.

I pretty much did this yesterday, so hopefully Jeff will pick up the  
patches and push them to linus with his next set of fixes for 2.6.20.

- k
