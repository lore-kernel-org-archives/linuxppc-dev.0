Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 26491DDEE8
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 03:44:15 +1000 (EST)
In-Reply-To: <46E6CBB9.90008@freescale.com>
References: <11895258991411-git-send-email-timur@freescale.com>
	<46E6CBB9.90008@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0504E7DF-D3C4-48D3-934D-AEA5888DEC2D@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH] [POWERPC] QE: simplify GUEMR register initialization
Date: Tue, 11 Sep 2007 12:47:01 -0500
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 11, 2007, at 12:09 PM, Timur Tabi wrote:

> Paul and Kumar,
>
> It turns out that I have a bunch more QE library code clean-up, so  
> please ignore this patch.  I'll submit a more comprehensive one  
> later this week.
>
> Timur Tabi wrote:
>> The initialization of the QE's GUEMR register is overly  
>> complicated, involving
>> multiple functions and a redundant ucc_common structure.  This  
>> patch removes
>> struct ucc_common, merges ucc_init_guemr() into ucc_set_type()  
>> (every caller
>> of ucc_init_guemr() also calls ucc_set_type() immediately  
>> afterward), and
>> removes the unused enum ucc_pram_initial_offset.

ok

- k
