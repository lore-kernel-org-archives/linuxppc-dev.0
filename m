Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc1-s12.bay0.hotmail.com (bay0-omc1-s12.bay0.hotmail.com
	[65.54.246.84]) by ozlabs.org (Postfix) with ESMTP id E208767B56
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 22 Oct 2006 21:22:02 +1000 (EST)
Message-ID: <BAY110-F1443E16DEC18B89BFA5881B2030@phx.gbl>
In-Reply-To: <BAY117-F26E839E935D9A3C03E365EC8020@phx.gbl>
From: "Ming Liu" <eemingliu@hotmail.com>
To: jrocnuck@hotmail.com
Subject: Re: how to reserve memory in linux?
Date: Sun, 22 Oct 2006 11:21:59 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
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

Dear Eric,

>Have you tried the function
>
>alloc_bootmem_low() early in the boot process in main.c ?
>
Yes, it sounds reasonable. With this function, I can reserve a large amount 
of buffer during booting time. But I think maybe it will be better to put 
this function in the device driver and when booting time, the driver is 
loaded and the memory part is reserved for later use, right?

Thanks for your idea so much. It's really helpful.

Regards
Ming

_________________________________________________________________
√‚∑—œ¬‘ÿ MSN Explorer:   http://explorer.msn.com/lccn  
