Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 09984DDFCE
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 06:02:33 +1000 (EST)
Message-Id: <2E8F6237-3AE5-4C57-A706-1E73FA6070E5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <49EF7394.30606@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: removing get_immrbase()??
Date: Wed, 22 Apr 2009 15:00:24 -0500
References: <A6732FD8-FBC6-420F-9318-CC111D266993@kernel.crashing.org>
	<49EF7394.30606@freescale.com>
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 22, 2009, at 2:44 PM, Scott Wood wrote:

>> CPM/QE related users.
>> arch/powerpc/include/asm/cpm1.h:#define IMAP_ADDR         
>> (get_immrbase())
>>    only used drivers/net/fs_enet/fs_enet-main.c which seems evil.
>
> That driver *is* evil. :-)
>
> It looks like the only remaining user of fs_enet_immap (which is  
> what IMAP_ADDR is used to initialize) is in mac-fec.c, under  
> CONFIG_DUET -- which hasn't been touched since 2005 and appears to  
> have died with arch/ppc.
>
> I'm fine with removing it -- it probably no longer compiles anyway.

I'll send DaveM a bit to kill it off.

- k
