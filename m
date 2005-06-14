Return-Path: <acurtis@onz.com>
In-Reply-To: <OQa9KclZrJxs$vCkAaFuL$rXNJWNzE@leo_guo>
References: <OQa9KclZrJxs$vCkAaFuL$rXNJWNzE@leo_guo>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e5570bf9e16d7d895f5d2658a4cc3775@onz.com>
From: Allen Curtis <acurtis@onz.com>
Date: Tue, 14 Jun 2005 07:21:03 -0700
To: leo_guo@jisung.cn
Cc: wolfgang@denx.de, linuxppc-embedded-request@ozlabs.org,
	linuxppc-embedded@ozlabs.org
Subject: Re: boot kernel problem?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

0xc0000000 is where the kernel is located in virtual space, after boot 
and initialization.

On Jun 14, 2005, at 1:00 AM, leo_guo@jisung.cn wrote:

> Hi all,
>
> For MPC82xx, running U-BOOT-1.1.2 and linux-2.4.24, I have a question:
>
> After uboot download the kernel through net/serial or read out it from 
> flash, then it decompress the kernel to SDRAM, from the begin address 
> 0x0, and execute the first instruction.
>
> But I am puzzle that the linux kernel entry address is 0xc0000000(know 
> from file System.map), how
>  can the kernel bootup if you decompress the kernel to address 0x0? 
> And I know the MMU is off now.
>
>
> Best Regards!
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
