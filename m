Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 50E63DDE22
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 23:46:01 +1000 (EST)
Message-Id: <C813BB29-5145-4A52-BEEC-AC418C2AE78B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1213661215.8129.149.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH] powerpc/booke: Add support for new e500mc core
Date: Tue, 17 Jun 2008 08:45:47 -0500
References: <Pine.LNX.4.64.0806161045450.20181@blarg.am.freescale.net>
	<1213661215.8129.149.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 16, 2008, at 7:06 PM, Benjamin Herrenschmidt wrote:

> On Mon, 2008-06-16 at 10:46 -0500, Kumar Gala wrote:
>> The new e500mc core from Freescale is based on the e500v2 but with  
>> the
>> following changes:
>>
>> * Supports only the Enhanced Debug Architecture (DSRR0/1, etc)
>> * Floating Point
>> * No SPE
>> * Supports lwsync
>             ^^^^^^
>
> It supports SMP ? Is tlbivax broadcast ? Is there a local form ?

All e500 (v1, v2, mc) have supported tlbivax broadcast, and e500mc  
does support local forms.

- k
