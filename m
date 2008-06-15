Return-Path: <hidave.darkstar@gmail.com>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.188])
	by ozlabs.org (Postfix) with ESMTP id 5130FDDE16
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Jun 2008 21:05:38 +1000 (EST)
Received: by ti-out-0910.google.com with SMTP id w7so1717774tib.13
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Jun 2008 04:05:36 -0700 (PDT)
Message-ID: <a8e1da0806150405j3e97a7e2s2b66f1edf04f72ff@mail.gmail.com>
Date: Sun, 15 Jun 2008 19:05:36 +0800
From: "Dave Young" <hidave.darkstar@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: macmini g4 can't boot with new kernel
In-Reply-To: <1213513445.8129.91.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <a8e1da0806142112v6969d22v45731a1ff821c5df@mail.gmail.com>
	<1213513445.8129.91.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jun 15, 2008 at 3:04 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Sun, 2008-06-15 at 12:12 +0800, Dave Young wrote:
>> Hi,
>>
>> I recently built kernel 2.6.26-rc5 for my macmini g4, but it can't
>> boot. I'm not sure if it's related to kernel or yaboot, or the open
>> firmware.
>>
>> My distribution is yellowdog 6.1, config file attached
>>
>> After load the kernel , it reports:
>>
>> zImage starting : loaded at 0x004001f8 (SP:0x0023eea4)
>> Allocating 0xc04b26c1 bytes
>> ...
>> Invalid memory access at %SRR0 : 004020e4 %SRR1 : 00003030
>
> What are you trying to boot precisely ?

It's arch/powerpc/boot/zImage

>
> >From yaboot, I would suggest you try to boot a straight vmlinux rather
> than a zImage. The later's never been really supported.

Thanks a lot, I didn't know this before.
vmlinux works indeed.

-- 
Regards
dave
