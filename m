Return-Path: <chris@alcor.co.uk>
Received: from mizar.alcor-electronics.co.uk (alcor.demon.co.uk [62.49.62.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 00DB42BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 14 Nov 2004 08:11:29 +1100 (EST)
From: "Chris Down" <chris@alcor.co.uk>
To: <wd@denx.de>
Date: Sat, 13 Nov 2004 21:11:18 -0000
Message-ID: <000601c4c9c5$514b34c0$0101a8c0@alcor1>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20041113192802.C6DFEC1430@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Problem bringing up Linux on Custom MPC852 Board 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> ...
> > At this point it stops executing in arch_kernel_thread.
> 
> I bet some beer that this is actually a FAQ - see 
> http://www.denx.de/twiki/bin/view/DULG/LinuxCrashesRandomly
> 
> This phenomenon is typical for a novice's port of U-Boot.
> 

Wolfgang, thanks for your reply. I will re-check the SDRAM initialisation and
UPM programming.

Regards

Chris Down
