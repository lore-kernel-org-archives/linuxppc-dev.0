Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 6203D2BDCF
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2004 22:15:43 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id i8LCFx7X023918
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2004 15:15:59 +0300 (EEST)
Message-ID: <41501648.6040302@intracom.gr>
Date: Tue, 21 Sep 2004 14:53:44 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: "Smith, Craig" <craig.d.smith@siemens.com>
References: <EA78B62757AF1E4799828249310AC4CA071D281F@stca206a.bus.sc.rolm.com>
In-Reply-To: <EA78B62757AF1E4799828249310AC4CA071D281F@stca206a.bus.sc.rolm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, 'Song Sam' <samlinuxppc@yahoo.com.cn>
Subject: Re: Linux 2.6.x on 8xx status
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Smith, Craig wrote:

>>Guess what? It WORKED!!! Just one more line make it.
>>Could you pls tell us the theory in it if not too
>>complicated? :-)
>>
>Genius. That patch appears to work for me as well.
>
>However, I'm still not able to debug via gdb/BDI2000.
>I'm getting the ol' "MMU: address translation for 0xc----- failed".
>I'm using the same BDI config file that works fine for debugging
>a 2.4.26 kernel on the same hardware, I've verified that I have
>CONFIG_BDI_SWITCH=y etc. Is this another known issue with 2.6
>on 8xx platforms? Has anyone had success debugging via BDI2000 on an 8xx
>board?
>If so, could you share your config file or hints as to why it should behave
>differently (i.e. not work) with a 2.6 kernel? Thanks.
>
>Regards,
>-Craig
>
>
>
BDI2000 does not work for 8xx 2.6 ATM.

Dan should probably get it to work when he has time.
At least that's what I hope...

Regards

Pantelis
