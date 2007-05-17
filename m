Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C14E0DDE25
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 23:00:11 +1000 (EST)
In-Reply-To: <76ac246f0188437c6ad8922466947f88@kernel.crashing.org>
References: <Pine.LNX.4.64.0705151715200.17092@localhost.localdomain>
	<17996.13115.456275.413478@cargo.ozlabs.ibm.com>
	<76ac246f0188437c6ad8922466947f88@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <80F45B52-BA80-481E-BEB5-9F3F3CCA5CE2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'for_paulus' branch
Date: Thu, 17 May 2007 07:58:25 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 17, 2007, at 7:05 AM, Segher Boessenkool wrote:

>>> -	.comm	next_slot,4
>>> -	.comm	primary_pteg_full,4
>>> -	.comm	htab_hash_searches,4
>>> +	.section .bss
>>> +	.align	2
>>> +next_slot:
>>> +	.space	4
>>> +primary_pteg_full:
>>> +	.space	4
>>> +htab_hash_searches:
>>> +	.space	4
>>> +	.previous
>
> Looks like it is missing some .globl?

Yep, on ARCH=powerpc we don't have the ppc_htab.c code so this didn't  
show up.  Odd, I swore I built an ARCH=ppc kernel.  Its now fixed in  
my tree.

- k
