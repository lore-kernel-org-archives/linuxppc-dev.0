Return-Path: <roto@gmx.net>
Received: from mail.gmx.net (unknown [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 812206870D
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2005 11:25:03 +1100 (EST)
Date: Fri, 11 Nov 2005 01:24:55 +0100
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20051111002455.GA3126@localhost>
References: <1130999620.4680.28.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1130999620.4680.28.camel@gaston>
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

Hi Ben

Thanks for your work, for the patches: on a Titanium IV a kernel-org
based, self-made (via "make-kpkg") 2.6.14.1 patched kernel works. USB
seems being fine here: I put the machine to sleep with a camera and a
Logitech mouse plugged in to USB connectors: After resuming the system
from sleep the mouse is still working, and the camera is usable and
fine. I'm running pbbuttons here.

It seems I have problems because of a - I still can't believe that -
missing pcmciautils package on Debian. But that's unrelated to what
we're discussing here, I believe. I'll start another thread perhaps for
this latter issue ...

On Thu, Nov 03, 2005 at 05:33:39PM +1100, Benjamin Herrenschmidt wrote:
> For those who experience crashes on sleep and/or wakeup (typically due
> to USB) with 2.6.14, I made a test patch that might help. Please let me
> know if it makes things more reliable.
> 
> http://gate.crashing.org/~benh/fix-ohci-sleep.diff

                         [ ... ]


I didn't use the one above, but just the one you posted here Nov.8
(this thread), IINM:

$ patch -p1 < /home/shorty/downloads/ben-patches/benh.nov.8.sleep.diff
patching file drivers/usb/core/hcd-pci.c
patching file drivers/usb/core/hcd.c
patching file drivers/usb/core/hcd.h
patching file drivers/usb/host/ehci-hcd.c
patching file drivers/usb/host/ehci-q.c
patching file drivers/usb/host/ehci-sched.c
patching file drivers/usb/host/ohci-hcd.c
patching file drivers/usb/host/ohci-hub.c
patching file drivers/usb/host/ohci-pci.c
patching file drivers/usb/host/uhci-hcd.c


Following that, provided my .bash_history is well organised enough to
be trusted ( ... :) I applied the 2.6.14.1 patch
("patch-2.6.14.1.bz2")

So: As to sleep/USB: Everything seems being fine here on 2.6.14.1.

FYI:
Kismet still does not seem work for hermes/orinoco on 2.6.14.1.

Thanks again for the patches, Ben.

Best Regards
Wolfgang

-- 
Wolfgang Pfeiffer
http://profiles.yahoo.com/wolfgangpfeiffer

Key ID: E3037113
Key fingerprint = A8CA 9D8C 54C4 4CC1 0B26  AA3C 9108 FB42 E303 7113
