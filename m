Return-Path: <nm127@freemail.hu>
Received: from relay01.digicable.hu (relay01.digicable.hu [92.249.128.189])
	by ozlabs.org (Postfix) with ESMTP id 403EFB7067
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Mar 2010 21:00:47 +1100 (EST)
Message-ID: <4B937947.4080306@freemail.hu>
Date: Sun, 07 Mar 2010 11:00:39 +0100
From: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127@freemail.hu>
MIME-Version: 1.0
To: Per-Erik Johansson <perka@dtek.chalmers.se>
Subject: Re: Linux on Freescale e200
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Per-Erik,

I found your message at
http://lists.ozlabs.org/pipermail/linuxppc-dev/2007-December/048539.html
back from Dec 2007.

Have you managed to run Linux on phyCORE-MPC5554 since then?

Regards,

	Márton Németh

>>> Hi
>>>
>>> I'm wondering if someone has ever tried to get Linux running on a
>>> Freescale e200 core?
>>> I found a patch to the Linux kernel from back in 2005:
>>> (http://linux.derkeiler.com/Mailing-Lists/Kernel/2005-06/5731.html)
>>> And it is listed as a processor type in Linux-2.6.23.11
>>> I know that there has been some confusion about e200 and e500 cores,
>>> old
>>> e200 renamed to e500, but from what I understand the e200 core now
>>> listed
>>> in the kernel is the one currently being used in MPC55xx
>>>
>>> I'm having a MPC5554, e200z6 core, that I'm supposed to get Linux
>>> running
>>> on (master thesis) and any pointers and tips are appreciated.
>>> Just finished porting/tweaking the Redboot boot loader, and I'm now
>>> moving
>>> on to the Linux (porting?) part.
>>
>> I'd suggest looking at getting u-boot running instead since that's we
>> use on the majority of freescale PPCs.
>>
>> We did a port a while back to the e200.. so most of the basic bits
>> should be there.  There might be some bit rot from its like of usage.
>>
>> What peripheral set are you looking to get working on the 5554?
>>
>> - k
>>
>
> Had a look into UBoot at first but didn't find any port for the
> MPC55xx/e200, so when we stumbled upon a "working" ecos/redboot port we
> went with that..
> Do you know where I could find the uboot port for the e200?
>
> We have phycore dev. kit
> (http://www.phytec.com/products/rdk/PowerPC/phyCORE-MPC5554.html)
> Just supposed to get it up and running, so peripherals will just be
> serial, ethernet and maybe CAN.
>
> / Per-Erik
