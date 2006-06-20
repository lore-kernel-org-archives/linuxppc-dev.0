Return-Path: <hilichen2000@msn.com>
Received: from hotmail.com (bay110-f6.bay110.hotmail.com [65.54.229.16])
	by ozlabs.org (Postfix) with ESMTP id 1277467B32
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Jun 2006 19:10:38 +1000 (EST)
Message-ID: <BAY110-F6CB7A492DE83E6E81F18DC3870@phx.gbl>
In-Reply-To: <4496B0AA.60909@esd-electronics.com>
From: =?gb2312?B?s8Ig1MY=?= <hilichen2000@msn.com>
To: matthias.fuchs@esd-electronics.com
Subject: Re: could linux support to configure the PLB-PCI bridge of PPC440
	into adapter mode
Date: Tue, 20 Jun 2006 17:10:29 +0800
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

hi Matthias:
   thank for your reply.
   according to information you provide, i should set the proper parameter 
of register of PPC440GX in U-BOOT(I use u-boot as bootloader),such as 
PAE,PHCE,PISE of SDR0_XCR and BAR etc.  during the time of linux kernel 
booting, I turn off CONFIG_PCI , let linux kernel don't initialize the PCI 
bus as host bridge and set PLB address in kernel.  then after the linux 
system operated, the ppc440gx could act as adapter mode. does my 
understanding correct? 
   i really appreciate your help.

 chen 


>From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
>To: hilichen2000@msn.com
>CC: linuxppc-embedded@ozlabs.org
>Subject: Re: could linux support to configure the PLB-PCI bridge of PPC440 
into	adapter mode
>Date: Mon, 19 Jun 2006 16:11:54 +0200
>
>Hi chen,
>
>it's not easy to setup the PCI-to-PLB mapping in a generic way so 
>that is gets into the kernel. Also it might be too late when the 
>adapter OS configures the bridge. The bridge must be setup quickly 
>after reset so that the host OS can assign resources to the card. 
>The bootloader of your board might be a good place to setup of the 
>adapter stuff. At least number and sizes of the needed address 
>spaces should be setup early.
>The PLB address can be setup or modified later (e.g. from the target 
>OS).
>
>>hi,now I want to use PPC440GX as PCI adapter card bridge. according 
>>to user manual, the PLB-PCI bridge should be configured to Adapter 
>>mode. after check some code of PCI of linux, i find the linux only 
>>support configuring the PLB-PCI bridge into HOST mode. Is my 
>>understanding correct ? if the normal version of linux don't 
>>support the adapter mode, could i found the patch?
>Probably not.
>
>Matthias
>
>
>
>

_________________________________________________________________
享用世界上最大的电子邮件系统— MSN Hotmail。  http://www.hotmail.com  
