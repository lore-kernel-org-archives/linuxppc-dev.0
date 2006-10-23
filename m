Return-Path: <jrocnuck@hotmail.com>
Received: from bay0-omc2-s38.bay0.hotmail.com (bay0-omc2-s38.bay0.hotmail.com
	[65.54.246.174]) by ozlabs.org (Postfix) with ESMTP id 70E0C67A39
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 23 Oct 2006 10:32:48 +1000 (EST)
Message-ID: <BAY117-F28276367733DA8D327BF3CC8000@phx.gbl>
In-Reply-To: <BAY110-F1443E16DEC18B89BFA5881B2030@phx.gbl>
From: "Eric Nuckols" <jrocnuck@hotmail.com>
To: eemingliu@hotmail.com
Subject: Re: how to reserve memory in linux?
Date: Sun, 22 Oct 2006 20:20:39 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
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

>Dear Eric,

>>Have you tried the function
>>
>>alloc_bootmem_low() early in the boot process in main.c ?
>>
>Yes, it sounds reasonable. With this function, I can reserve a large amount 
>of buffer during >booting time. But I think maybe it will be better to put 
>this function in the device driver and when >booting time, the driver is 
>loaded and the memory part is reserved for later use, right?

Actually, you can only do this at boot time before any of the standard 
memory setup routines run.
Consult the linux device drivers book and also do some internet research on 
the subject to get the "official" documentation of this functionality.  I'd 
rather you get the information from these sources than from me, since there 
is plenty of room for error when using these functions.

Here's a link I found to the book: (the 2nd Edition)
http://www.xml.com/ldd/chapter/book/ch07.html



>Thanks for your idea so much. It's really helpful.

>Regards
>Ming

_________________________________________________________________
√‚∑—œ¬‘ÿ MSN Explorer:   http://explorer.msn.com/lccn

_________________________________________________________________
All-in-one security and maintenance for your PC.  Get a free 90-day trial! 
http://clk.atdmt.com/MSN/go/msnnkwlo0050000002msn/direct/01/?href=http://www.windowsonecare.com/?sc_cid=msn_hotmail
