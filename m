Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 87CEFDDEFD
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Feb 2008 01:22:04 +1100 (EST)
Message-Id: <F2D42185-1056-41F3-8A8C-2101054A8E7A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: maxime louvel <m.louvel@gmail.com>
In-Reply-To: <dda529d0802280031o23fb8de1ya5de2db876013e0b@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: 2.6.25-rc3 on mpc8548amc doesn't boot
Date: Thu, 28 Feb 2008 08:21:58 -0600
References: <dda529d0802270437o3ea1c9beld7d65f5af2011a6f@mail.gmail.com>
	<dda529d0802270825p527fd1b5i3e5a72a16bd95a75@mail.gmail.com>
	<B3C9F997-0D0B-4033-9FED-F8B6B7F5DABC@kernel.crashing.org>
	<dda529d0802272356p5db9066s5a9aaa336e74ab81@mail.gmail.com>
	<dda529d0802280031o23fb8de1ya5de2db876013e0b@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Feb 28, 2008, at 2:31 AM, maxime louvel wrote:

> Hi,
>
> I have a question for submitting my changes:
> As I said I have commented a few line in arch/powerpc/boot/Makefile
> #$(obj)/4xx.o: BOOTCFLAGS += -mcpu=405
> #$(obj)/ebony.o: BOOTCFLAGS += -mcpu=405
> #$(obj)/cuboot-taishan.o: BOOTCFLAGS += -mcpu=405
> #$(obj)/cuboot-katmai.o: BOOTCFLAGS += -mcpu=405
> #$(obj)/treeboot-walnut.o: BOOTCFLAGS += -mcpu=40
>
> I guess that shouldn't be integrated in my patch, should I ?
> For what I have found on websearch that should come from my gcc  
> version (3.4.3 with specific stuff).
> But still I needed that...

I thought Josh published a patch to work around the toolchain issues  
people had.

But yes, this shouldn't be part of the patch :)

- k
