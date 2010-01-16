Return-Path: <wilbur512@gmail.com>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.210.179]) by ozlabs.org (Postfix) with ESMTP id 439B91007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 16 Jan 2010 23:35:53 +1100 (EST)
Received: by yxe9 with SMTP id 9so351499yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 16 Jan 2010 04:35:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1263573697-17839-1-git-send-email-linuxppc-dev@ml.breakpoint.cc>
References: <1263573697-17839-1-git-send-email-linuxppc-dev@ml.breakpoint.cc>
Date: Sat, 16 Jan 2010 20:35:50 +0800
Message-ID: <e997b7421001160435q83f5837rb931f8a16766ce91@mail.gmail.com>
Subject: Re: Kexec support for FSL-BookE, take two
From: "wilbur.chan" <wilbur512@gmail.com>
To: Sebastian Andrzej Siewior <linuxppc-dev@ml.breakpoint.cc>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2010/1/16 Sebastian Andrzej Siewior <linuxppc-dev@ml.breakpoint.cc>:
> This is take two :)
> SMP support did not work in the first one and due to the lack of a working
> SMP machine it is still absent. I took the e500v1 problem into account and
> the result is that I now use multiple 256MiB mappings.
> The final mapping covers the first 2GiB so the part of the highmem should
> be also covered and not just kernel memory.
>
> The first three patches prepare the entry code to work outside of the
> first page. Patch 4 simply moves code and finally patch 5 implements the
> kexec functionality.


Hi, sebastian

Is it possible to  avoid setting up  the 1:1 mapping  but to convert
physical address into virt before relocate , like mips do?

2010/1/16 Kumar Gala <galak@kernel.crashing.org>:

>
> What do you think we need for SMP support? I'm happy to test out on SMP HW (8572)
>

I'm happy to test it too   :D
