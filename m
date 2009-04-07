Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 53FDEDDFDE
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 00:39:48 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LrCSm-0002sr-92
	for linuxppc-dev@ozlabs.org; Tue, 07 Apr 2009 07:39:44 -0700
Message-ID: <22930588.post@talk.nabble.com>
Date: Tue, 7 Apr 2009 07:39:44 -0700 (PDT)
From: "Sauce.Cheng" <chmhou@sina.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: issue at the beginning of kernel booting
In-Reply-To: <20090402161209.GA19088@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <20090327083628.4C3E93EE530@mail2-203.sinamail.sina.com.cn>
	<20090327161522.GA7809@ld0162-tx32.am.freescale.net>
	<22840131.post@talk.nabble.com>
	<20090402161209.GA19088@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


thanks Scott 's following

> I don't quite follow the above, but what I meant is that you need to
> put a mapping in place that covers your LED I/O once you have the MMU on.
> Any mappings that U-boot made will be gone at that point.

i am sorry for my poor expression. i think i have got your meaning about
that.
the suggestion from others that the situation that external access will be
disabled at early booting time. i guess that means like yours, sometimes I/O
disabled due to cache operating or something.

certainly, if i have to turn LEDs at booting time, the way your said is the
best. but i supposed i could operate LEDs after early booting time. 

>> i tried 
>> CONFIG_PPC_EARLY_DEBUG_CPM=y 
>> CONFIG_PPC_EARLY_DEBUG_CPM_ADDR=0xf00000008	
>> how can i make sure CPM_ADDR, 0xf0000008 is default value 

> Look at the u-boot source, or dump the memory and see if it looks like a
> ring buffer.

sorry, i mean that CPM_ADDR is address of what? address of CPM registers or
something?

> This is a dts-v0 tree, which implies it's fairly old.
dose later dts be used in corresponding kernel version ?

i guess i must read "booting-without-of.txt". many of contents in dts i have
no idea.

in addition, there is one more question. 
my RAM size is 32MBytes, my "vmlinux" size is 30MBytes, "vmlinux.o" size is
58MBytes. so , will there be something wrong at uncompressing time ?

Sauce
-- 
View this message in context: http://www.nabble.com/issue-at-the-beginning-of-kernel-booting-tp22741532p22930588.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
