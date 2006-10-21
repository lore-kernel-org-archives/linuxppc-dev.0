Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc3-s9.bay0.hotmail.com (bay0-omc3-s9.bay0.hotmail.com
	[65.54.246.209]) by ozlabs.org (Postfix) with ESMTP id 3996B67B92
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 22 Oct 2006 00:22:28 +1000 (EST)
Message-ID: <BAY110-F2BA131ED0055064C26658B2020@phx.gbl>
In-Reply-To: <12c9fc1a0610202215k67f374d3ie3db3d6cbfb82180@mail.gmail.com>
From: "Ming Liu" <eemingliu@hotmail.com>
To: urwithsudheer@gmail.com
Subject: Re: how to reserve memory in linux?
Date: Sat, 21 Oct 2006 14:22:25 +0000
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

Dear sudheer,
About the "mem=xx" argument, I checked it from the website and got such a 
explanation:

This argument has several purposes: The original purpose was to specify the 
amount of installed memory (or a value less than that if you wanted to 
limit the amount of memory available to linux).

>From the argument above, it says "mem=xx" is to specify the amount of 
memory available to Linux. I am not sure if I am right, but I think if I 
use such an argument, that reserved part (that 5MB you mentioned), is not 
available any more for Linux to access it. 

My original meaning is: specify a fixed physical address for a mount of 
memory for reserved use. The point is to make this part of memory fixed in 
the memory of physical address, and then another I/O peripheral could use 
DMA to access such a fixed physical address memory. However if I don't 
reserve such a part, I must let Linux to allocate such a memory part. And 
then Linux will not put it in a fixed physical address and then the 
peripheral will not know where is this part.

Am I right? Thanks for your idea.

Also other ideas are appreciated.

Regards
Ming

>Considering your setup as normal desktop, I hope this can be done by 
>giving
>"mem= xxm"  as the boot arguments.  Say the dmesg in your system 
>shows   "
>495MB LOWMEM available."  .  In the boot arguments you can give 
>mem=490m
>saying the linux to use only 490MB . The rest 5MB can be used later 
>as you
>wish.

_________________________________________________________________
享用世界上最大的电子邮件系统— MSN Hotmail。  http://www.hotmail.com  
