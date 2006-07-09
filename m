Return-Path: <ammubhai@gmail.com>
Received: from mailgw.cs.york.ac.uk (mailgw.cs.york.ac.uk [144.32.40.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 03E2767B56
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  9 Jul 2006 20:58:25 +1000 (EST)
Message-ID: <44B0E0B1.2070608@gmail.com>
Date: Sun, 09 Jul 2006 11:55:45 +0100
From: Ameet Patil <ammubhai@gmail.com>
MIME-Version: 1.0
To: Ming Liu <eemingliu@hotmail.com>
Subject: Re: Kernel hangs after "Now booting the kernel".
References: <BAY110-F31063B8294E4D0F3D164F6B2750@phx.gbl>
In-Reply-To: <BAY110-F31063B8294E4D0F3D164F6B2750@phx.gbl>
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

Hi Ming,
   Check if the kernel boot options are set right? (ie.
console=ttyS0,9600 root=/dev/xsa3). Sometimes the configuration is lost.
If this is intact, then another thing to try is to start from the
beginning: make mrproper and then make menuconfig, etc.

I have not looked into TEMAC patch yet, but don't think it would affect
your serial output messages. Double check the boot options and whether
you have included support for legacy serial device/ console on serial
deivce.

-Ameet

Ming Liu wrote:
> Dear Ameet,
> I really feel so sorry to take away much time from you. However, there 
> are really so many strange problems for my system.
> 
> I tried to implement the Temac option and recompiled the kernel. Then 
> when I boot the kernel from CF card, after the information "Now booting 
> the kernel", it hangs. I canceled the Temac again and recompiled the 
> kernel, restoring the former condition, this problem still existed. It's 
> so strange.
> 
> Any suggestion to solve this? Of course, suggestions from other friends 
> are also appreciated.
> 
> Thanks a lot again for your great help!
> 
> Regards
> Ming
> 
> _________________________________________________________________
> 与联机的朋友进行交流，请使用 MSN Messenger:  http://messenger.msn.com/cn 
> 
