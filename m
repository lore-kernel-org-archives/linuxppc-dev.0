Return-Path: <hollis@penguinppc.org>
Received: from asmtp-a063f31.pas.sa.earthlink.net
	(asmtp-a063f31.pas.sa.earthlink.net [207.217.120.133])
	by ozlabs.org (Postfix) with ESMTP id D561B2BD3C
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Sep 2004 05:54:29 +1000 (EST)
In-Reply-To: <20040916182531.GA20649@george.solinno.co.uk>
References: <20040916182531.GA20649@george.solinno.co.uk>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <EF4D4AFC-0815-11D9-81F8-000A95A0560C@penguinppc.org>
From: Hollis Blanchard <hollis@penguinppc.org>
Date: Thu, 16 Sep 2004 14:23:48 -0500
To: leigh@solinno.co.uk (Leigh Brown)
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: Re: [PReP][PATCH] Fix ISA PIC interrupt acknowledge address
	detection
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sep 16, 2004, at 1:25 PM, Leigh Brown wrote:

> The ISA PIC address for acknowledging interrupts is actually defined
> in residual data as a 32-bit system address, rather than a 32-bit
> memory address.  This is rather embarrasing, as I don't think this
> function has done the right thing, ever.
>
> Tested and working fine on my Carolina and 140.

And this is important, as 2.6.9-rcX suffer from the dreaded Carolina 
"lost interrupt" problems. Could we try to get this patch into 2.6.9 
final?

-Hollis
