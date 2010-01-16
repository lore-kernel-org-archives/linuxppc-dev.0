Return-Path: <sebastian@breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 73FE0B7CA0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 17 Jan 2010 00:11:03 +1100 (EST)
Date: Sat, 16 Jan 2010 13:52:08 +0100
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: "wilbur.chan" <wilbur512@gmail.com>
Subject: Re: Kexec support for FSL-BookE, take two
Message-ID: <20100116125208.GA25091@Chamillionaire.breakpoint.cc>
References: <1263573697-17839-1-git-send-email-linuxppc-dev@ml.breakpoint.cc>
	<e997b7421001160435q83f5837rb931f8a16766ce91@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <e997b7421001160435q83f5837rb931f8a16766ce91@mail.gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* wilbur.chan | 2010-01-16 20:35:50 [+0800]:

>Is it possible to  avoid setting up  the 1:1 mapping  but to convert
>physical address into virt before relocate , like mips do?
No.

>2010/1/16 Kumar Gala <galak@kernel.crashing.org>:
>
>>
>> What do you think we need for SMP support? I'm happy to test out on SMP HW (8572)
>>
>
>I'm happy to test it too   :D

I have a 8572 myself but it is not working reliably right now. I will
try to merge the userland pieces and then I will probably look at SMP.

Sebastian
