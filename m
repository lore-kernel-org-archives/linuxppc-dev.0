Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E3107DDE3C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Mar 2007 01:58:13 +1100 (EST)
In-Reply-To: <c1bf1cf0703122005l5014824r3e5fbfd50f1974ce@mail.gmail.com>
References: <c1bf1cf0703122005l5014824r3e5fbfd50f1974ce@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8BE4BF8E-A32E-4984-9B1B-C3B6ED2A1BCA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Serial console not working on EP8343M
Date: Tue, 13 Mar 2007 09:57:15 -0500
To: Ed Swierk <eswierk@arastra.com>
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


On Mar 12, 2007, at 10:05 PM, Ed Swierk wrote:

> I'm having trouble getting the serial console to work on an EP8343M
> board when using U-Boot 1.2.0 to start Linux 2.6.20.1. I'm using arch
> powerpc and platform MPC834x_SYS (which is perhaps wishful thinking,
> as my board is different, although it should at least have the same
> serial port configuration).
>
> The symptoms are exactly the same as those in
> http://ozlabs.org/pipermail/linuxppc-embedded/2006-September/ 
> 024457.html:
> the console stops working after the call to console_init(). The
> suggested solution was to ensure that U-Boot is setting
> timebase-frequency, bus-frequency and clock-frequency and passing
> those properties to the kernel, and this does indeed seem to be
> happening in my case.
>
> I've attached the output from U-Boot (including a dump of the flat
> device tree), as well as my kernel config and U-Boot board settings.
> Any help would be appreciated.
>
> --Ed

Have you tried make the bootargs just console=ttyS0,115200 (or  
whatever your baud rate is)?

- k
