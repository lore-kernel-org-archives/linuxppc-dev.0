Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 5A07EDDDF0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Sep 2008 17:30:03 +1000 (EST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: nathael.pajani@ed3l.fr
Subject: Re: SM722 (Lynx3DM+) framebuffer driver
Date: Thu, 18 Sep 2008 09:28:18 +0200
References: <200609271226.06115.matthias.fuchs@esd-electronics.com>
	<48C7B602.9040404@ed3l.fr>
In-Reply-To: <48C7B602.9040404@ed3l.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200809180928.18689.matthias.fuchs@esd-electronics.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Nathael,

your driver seems to be the most complete framebufferdriver for this chip
I heard about :-)

Our driver is currently based on some register dumps by SMI. The chip is completely
setup by U-Boot. Because of it's missing generic'ness I did not dare to post it
as a patch to the U-Boot list :-) Finally we are using a stupid framebuffer driver
that does absolutely no 722 setup. It just represents the framebuffer driver interface.

I will give your driver a try.

On Wednesday 10 September 2008 13:56, Nathael Pajani wrote:
> Hi !
> I know your mail is quite old, but this might still prove useful....
> and did you find a solution ?
> Do you finally have a driver ? I'm interested in whatever information you have, 
> even the links to 2.4 kernel code, or code for SM712 chips. Anything at all in 
> fact, so I may try to improve my driver.
> 
> I have this device (Silicon Motion SM722 Lynx3DM+) on a powerPC board from ACTIS 
> Computers.
> 
> You'll find attached a patch with the SMI driver I made.
> It's not as good as it should be, be I have a usable display, being able to use 
> xorg, and it's as much as I managed without a vgabios (which they provide for 
> x86 arch only).
> Note also that uboot on the board does some chip init, so this driver alone may 
> not be useful if you don't already have something.
I assume that you enable access to the memory mapped register in U-Boot, right?
> 
> Note also that for my brain's sake I removed parts handling LynxEM chips from 
> the original code (which was mainly for mips VR5701-SG2 with LynxEM+).
> 
> Have fun, and thank you if you can send in some useful stuff.
> ++++
> 

Matthias
