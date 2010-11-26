Return-Path: <wmb@firmworks.com>
Received: from rs35.luxsci.com (rs35.luxsci.com [66.216.127.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B157FB70CC
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Nov 2010 18:36:58 +1100 (EST)
Message-ID: <4CEF6373.60105@firmworks.com>
Date: Thu, 25 Nov 2010 21:36:19 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: RFC: Mega rename of device tree routines from of_*() to dt_*()
References: <1290607413.12457.44.camel@concordia>	
	<1290692075.689.20.camel@concordia>	
	<AANLkTiknyKi1pzvUP2WnasudZwH27-a0FxCX0BSHBdQp@mail.gmail.com>	
	<1290741341.9453.377.camel@concordia>
	<4CEF3AB1.9060200@firmworks.com>
	<1290750606.9453.394.camel@concordia>
In-Reply-To: <1290750606.9453.394.camel@concordia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linux-arch <linux-arch@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, sparclinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrea Scian <andrea.scian@dave.eu>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>> One Laptop Per Child ships real Open Firmware on its x86 Linux systems,
>> of which approximately 2 million have been shipped or ordered.  An ARM
>> version, also with OFW, is in the works.
>
> OK. I don't see any code under arch/x86 or arch/arm that uses of_()
> routines though? Or is it under drivers or something?
>

Andres Salomon has been working for some time to get some Open Firmware 
support for x86 upstream.  As you can probably imagine, it has been slow 
going, but seems to be getting close.

The OLPC ARM work is just beginning, so nothing has been submitted yet. 
  The first hardware prototypes are still being debugged. Lennert 
Buytenhek is the key OS person who will be involved.
