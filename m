Return-Path: <eddy.petrisor@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.205])
	by ozlabs.org (Postfix) with ESMTP id CE77E68713
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Nov 2005 08:48:25 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id x3so837031nzd
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2005 13:48:24 -0800 (PST)
Message-ID: <43751182.1020009@gmail.com>
Date: Fri, 11 Nov 2005 23:47:46 +0200
From: Eddy Petrisor <eddy.petrisor@gmail.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1130999620.4680.28.camel@gaston>	
	<51ad2e0d0511051358p2fe15f1i7278615996183eb1@mail.gmail.com>
	<1131229041.5229.29.camel@gaston>
In-Reply-To: <1131229041.5229.29.camel@gaston>
Content-Type: text/plain; charset=x-user-defined; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: 2.6.14 USB vs. sleep issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Benjamin Herrenschmidt wrote:
> On Sat, 2005-11-05 at 22:58 +0100, Bin Zhang wrote:
> 
>>On 11/3/05, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>>
>>>For those who experience crashes on sleep and/or wakeup (typically due
>>>to USB) with 2.6.14, I made a test patch that might help. Please let me
>>>know if it makes things more reliable.
>>>
>>
>>I've tried your patch with usb wifi dlink dwl-g122 (my eth1). It works.
>>There are some differences in /var/log/syslog :
> 
> 
> I have another patch tho:

With this patch the kernel panics on my PowerBook 5,2

I made a few pictures with my phone and I can put them smewhere, if needed.

I will try tonight the third patch you proposed and the kernel is 
compiling now...


BTW, is there any difference between the resulted .ko files when made with:

make SUBDIRS=drivers/usb/core

make SUBDIRS=drivers/usb/core modules

and what the make command ran from the root of the kernel source?

-- 
Regards,
EddyP
=============================================
"Imagination is more important than knowledge" A.Einstein
