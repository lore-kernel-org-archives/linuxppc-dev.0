Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 86B33DDED6
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 18:01:35 +1100 (EST)
In-Reply-To: <18382.12838.527446.325768@cargo.ozlabs.ibm.com>
References: <1204301097.14759.6.camel@localhost.localdomain>
	<1204340690.15052.457.camel@pasglop>
	<18382.7074.69060.661720@cargo.ozlabs.ibm.com>
	<d495403c2b5f700be085c965746cd211@kernel.crashing.org>
	<18382.12838.527446.325768@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5b485b22fcd97d89ee82f1fa5c1940db@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] add strncmp to PowerPC
Date: Wed, 5 Mar 2008 08:01:20 +0100
To: Paul Mackerras <paulus@samba.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Anyway, this asm code has bugs, as do both the current C version in 
>> the
>> kernel, and the code I posted.  We need to do better :-)
>
> The only bug I know of in the asm code is the behaviour when the count
> is zero.  Do you know of any other?

No, that's the bug I meant.  Sorry for using such inexact language.


Segher
