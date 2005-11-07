Return-Path: <ce@idtect.com>
Received: from smtp-out.fr.clara.net (smtp-out.fr.clara.net [212.43.194.59])
	by ozlabs.org (Postfix) with ESMTP id 0B6AF686B4
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Nov 2005 20:37:54 +1100 (EST)
Message-ID: <436F1A9E.80105@idtect.com>
Date: Mon, 07 Nov 2005 10:13:02 +0100
From: Charles-Edouard Ruault <ce@idtect.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1130999620.4680.28.camel@gaston>
In-Reply-To: <1130999620.4680.28.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: 2.6.14 USB vs. sleep issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

>For those who experience crashes on sleep and/or wakeup (typically due
>to USB) with 2.6.14, I made a test patch that might help. Please let me
>know if it makes things more reliable.
>
>http://gate.crashing.org/~benh/fix-ohci-sleep.diff
>
>Note that the patch is totally untested here so it may be just plain
>bogus :)
>
>Ben.
>
>
>
>  
>
Hi Ben,
i've applied your patch and it seems that when i put my powerbook to
sleep ( by closing the lid ) the kernel just crashes since everytime i
come back, the machine is turned off. I had a look at the logs and i see
that i'm having a reboot almost immediateley after the lid is closed.
However i've got no trace of a kernel panic .....
my conf:

Linux kaluha 2.6.14 #1 PREEMPT Mon Oct 31 10:28:22 CET 2005 ppc GNU/Linux
processor       : 0
cpu             : 7447/7457, altivec supported
clock           : 612MHz
revision        : 0.1 (pvr 8002 0101)
bogomips        : 406.52
machine         : PowerBook5,2
motherboard     : PowerBook5,2 MacRISC3 Power Macintosh
detected as     : 287 (PowerBook G4 15")
pmac flags      : 0000001b
L2 cache        : 512K unified
memory          : 768MB
pmac-generation : NewWorld

I have a usb mouse that i unplug before closing the lid.
Anything else that can be usefull ?
Thanks for your time.
Regards.


-- 
Charles-Edouard Ruault

+33 1 55 34 76 65
ce@idtect.com

Idtect SA
37 Bd des Capucines 
75002 Paris, France
www.idtect.com
