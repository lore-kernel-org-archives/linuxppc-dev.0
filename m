Return-Path: <kumar.gala@freescale.com>
Received: from motgate2.mot.com (motgate2.mot.com [144.189.100.101])
	by ozlabs.org (Postfix) with ESMTP id 000792BDB3
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Oct 2004 13:11:23 +1000 (EST)
In-Reply-To: <35fb2e59040930165327f2dd59@mail.gmail.com>
References: <35fb2e59040930165327f2dd59@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <87127382-1357-11D9-8EFC-000393DBC2E8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 30 Sep 2004 22:11:03 -0500
To: <jonathan@jonmasters.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: bi_recs
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> > But on the other hand, I've given up a long time ago trying to 
> enforce any
>  > kind of sane model on ppc32 because the embedded folks only care 
> about having
>  > a quick ugly broken hack to work with their board, thus the 
> explosion of
>  > various incompatible boot_info structures that we have nowadays.
>
> Yes indeed. It's ugly and needs fixing so I'll take a look at it - I
>  just don't want to do this if everyone here already knows of a better
>  solution which will work.
>
> Then Xilinx et al can generate memory maps and we can head towards
>  having a single kernel binary bootable on multiple different ppc
>  boards.

I would be nice to have an extensive and dynamic way to pass info from 
the bootloader to the kernel.  I believe that Wolfgang has stated he 
would be willing to change u-boot to match.  I'd be willing to fixup 
and move Freescale boards over to use something as long as we get 
u-boot to support it as well.

I've been told that ARM has a solution, in place, to this problem that 
might always be worth looking at.

- kumar
