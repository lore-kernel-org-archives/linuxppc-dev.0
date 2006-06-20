Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id D5FA467B40
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Jun 2006 23:42:02 +1000 (EST)
Message-ID: <4497FAF0.3080701@esd-electronics.com>
Date: Tue, 20 Jun 2006 15:41:04 +0200
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
To: hilichen2000@msn.com
Subject: Re: could linux support to configure the PLB-PCI bridge of PPC440
	into adapter mode
References: <BAY110-F6CB7A492DE83E6E81F18DC3870@phx.gbl>
In-Reply-To: <BAY110-F6CB7A492DE83E6E81F18DC3870@phx.gbl>
Content-Type: text/plain; charset=GB2312
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

Hello chen,

that's how we do it on our boards (a couple of 405GP(r) based adapters).
We normally hide the top meg's of RAM so that it is not used by Linux.
We setup the PLB side of the bridge to point to this RAM so that it is
accessable from the PCI side.

Matthias
> hi Matthias:
>   thank for your reply.
>   according to information you provide, i should set the proper 
> parameter of register of PPC440GX in U-BOOT(I use u-boot as 
> bootloader),such as PAE,PHCE,PISE of SDR0_XCR and BAR etc.  during the 
> time of linux kernel booting, I turn off CONFIG_PCI , let linux kernel 
> don't initialize the PCI bus as host bridge and set PLB address in 
> kernel.  then after the linux system operated, the ppc440gx could act as 
> adapter mode. does my understanding correct?   i really appreciate your 
> help.
> 
> chen
