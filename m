Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <17248.45467.698310.551177@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.61.0510260956110.6094@linen.am.freescale.net>
	<17248.45467.698310.551177@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1C38E8D7-C93F-4524-B66A-55193B468B08@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 27 Oct 2005 08:45:04 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <galak@freescale.com>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: only build idle_6xx for 6xx
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 27, 2005, at 5:53 AM, Paul Mackerras wrote:

> Kumar Gala writes:
>
>
>> For the current time idle_6xx only applies to 6xx ppc32 CPUs
>>
>
>
>> +extra-$(CONFIG_6xx)        += idle_6xx.o
>>
>
>
>> -obj-$(CONFIG_PPC32)        += entry_32.o idle_6xx.o setup_32.o  
>> misc_32.o
>> +obj-$(CONFIG_PPC32)        += entry_32.o setup_32.o misc_32.o
>>
>
> Why does idle_6xx.o become an extra- rather than an obj- ?

Because I copied and pasted the line from arch/ppc/kernel/Makefile w/ 
o paying any attention to it.  I'll send a proper patch :)

(I'm really trying to see if you actually look at our patches or not :)

- kumar
