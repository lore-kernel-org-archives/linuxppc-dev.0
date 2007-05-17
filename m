Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EE197DDEE4
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 22:06:55 +1000 (EST)
In-Reply-To: <17996.13115.456275.413478@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.64.0705151715200.17092@localhost.localdomain>
	<17996.13115.456275.413478@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <76ac246f0188437c6ad8922466947f88@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Please pull from 'for_paulus' branch
Date: Thu, 17 May 2007 14:05:58 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> -	.comm	next_slot,4
>> -	.comm	primary_pteg_full,4
>> -	.comm	htab_hash_searches,4
>> +	.section .bss
>> +	.align	2
>> +next_slot:
>> +	.space	4
>> +primary_pteg_full:
>> +	.space	4
>> +htab_hash_searches:
>> +	.space	4
>> +	.previous

Looks like it is missing some .globl?


Segher
