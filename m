Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc2-s14.bay0.hotmail.com (bay0-omc2-s14.bay0.hotmail.com
	[65.54.246.150]) by ozlabs.org (Postfix) with ESMTP id D05B567B5A
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 10 Sep 2006 04:34:46 +1000 (EST)
Message-ID: <BAY110-F378469920DE25DF7AB6C28B2340@phx.gbl>
In-Reply-To: <1157823763.2670.2.camel@vader.jdub.homelinux.org>
From: "Ming Liu" <eemingliu@hotmail.com>
To: jwboyer@jdub.homelinux.org
Subject: RE: asm/*.h files missing for ppc arch.
Date: Sat, 09 Sep 2006 18:34:41 +0000
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

Dear Josh,

>How are you compiling?  For 4xx, you still need to specify ARCH=ppc with
>the make command.  There is some makefile hackery that will then bring
>in header files from asm-powerpc as needed.

In fact, I just try to compile the hello example in the book Linux Device 
Driver chapter 2. The Makefile is listed as:

#Makefile
ifneq ($(KERNELRELEASE),)
  obj-m := hello.o
else 
  KERNELDIR ?= /home/mingliu/linux-2.6.16
  PWD := $(shell pwd)

default:
  $(MAKE) -C $(KERNELDIR) M=$(PWD) modules
endif

Also, I have specified ARCH = ppc in my Linux kernel. But it seems that 
there is still some problem. Thanks for your suggestion.

Regards
Ming

_________________________________________________________________
享用世界上最大的电子邮件系统— MSN Hotmail。  http://www.hotmail.com  
