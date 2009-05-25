Return-Path: <hunter.cobbs@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id B157CDE2D1
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 23:23:16 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1511425yxb.39
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 06:23:15 -0700 (PDT)
Message-Id: <55DBD0E6-202A-463E-BF0D-EB00C334C9B9@gmail.com>
From: Hunter Cobbs <hunter.cobbs@gmail.com>
To: konamo <dai.michael@gmail.com>
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Mime-Version: 1.0 (iPhone Mail 5H11)
Subject: Re: AMCC 405ex memory size issue
Date: Mon, 25 May 2009 08:22:07 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Have you modified the hardware?  The default hardware specs says there  
is only 256MB of ram. Regardless, if you upped the ram amount, you  
might need to modify u-boot itself to turn on more address lines or  
you might consider looking at your memory management allocation (slab,  
slub, etc).

Hunter Cobbs

On May 25, 2009, at 1:15 AM, konamo <dai.michael@gmail.com> wrote:

>
> any ideas?
>
>
>
> konamo wrote:
>>
>> Hi all,
>> we are using AMCC 405ex kilauea eval board as a demo, not use any
>> pci/nand function,
>> the board configuration is below:
>> u-boot 2009.01,
>> linux-2.6.25-rc2,
>> 1GB DDR2 memory(2Gbit * 4, 1 rank),
>> AMCC powerpc 405ex,
>> both 1G and 512MB memory works fine under u-boot, but linux boot  
>> fails in
>> 1G memory, if we limit mem=512M, linux could boot over nfs. Could  
>> anyone
>> pls help us how to find the root cause? thanks
>>
>
> -- 
> View this message in context: http://www.nabble.com/AMCC-405ex-memory-size-issue-tp23631525p23701685.html
> Sent from the linuxppc-dev mailing list archive at Nabble.com.
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
