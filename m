Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 67AE8DDDF3
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jan 2007 02:52:29 +1100 (EST)
In-Reply-To: <20070113124638.GA13493@krispykreme>
References: <200701120100.l0C10ktW025821@toshiba.co.jp>
	<20070113124638.GA13493@krispykreme>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <06ebc2a1b06cafb9aaa3bcf8407db1fe@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 7/19] powerpc: interfaces to the hypervisor of Celleb
Date: Sat, 13 Jan 2007 16:53:04 +0100
To: Anton Blanchard <anton@samba.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> +#define	HVSC	.long	0x44000022
>
> Could you pick this up from the define in include/asm-powerpc instead?

Or just write "sc 1", everyone should have new enough binutils
by now.


Segher
