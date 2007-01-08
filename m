Return-Path: <khali@linux-fr.org>
Received: from kellthuzad.dmz.nerim.net (smtp-dmz-231-monday.dmz.nerim.net
	[195.5.254.231]) by ozlabs.org (Postfix) with ESMTP id 3B802DDE01
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2007 06:30:57 +1100 (EST)
Received: from kraid.nerim.net (smtp-101-monday.nerim.net [62.4.16.101])
	by kellthuzad.dmz.nerim.net (Postfix) with ESMTP id D4A1427129
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Jan 2007 20:11:23 +0100 (CET)
Date: Mon, 8 Jan 2007 20:11:30 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Sylvain Munaut <tnt@246tNt.com>, Greg KH <gregkh@suse.de>
Subject: Re: Linux 2.6.20-rc4
Message-Id: <20070108201130.46755bb9.khali@linux-fr.org>
In-Reply-To: <45A25C17.5070606@246tNt.com>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
	<200701081550.27748.m.kozlowski@tuxland.pl>
	<45A25C17.5070606@246tNt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>, paulus@samba.org, Linux
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Sylvain,

On Mon, 08 Jan 2007 15:58:31 +0100, Sylvain Munaut wrote:
> Mariusz Kozlowski wrote:
> > Hello,
> >
> > Doesn't build on iMac G3 machine. Relevant info attached.
> >
> > In file included from drivers/usb/host/ohci-hcd.c:893:
> > drivers/usb/host/ohci-ppc-soc.c:225: error: redefinition of '__inittest'
> > drivers/usb/host/ohci-pci.c:252: error: previous definition of '__inittest' was here
> > drivers/usb/host/ohci-ppc-soc.c:225: error: redefinition of 'init_module'
> > drivers/usb/host/ohci-pci.c:252: error: previous definition of 'init_module' was here
> > drivers/usb/host/ohci-ppc-soc.c:226: error: redefinition of '__exittest'
> > drivers/usb/host/ohci-pci.c:260: error: previous definition of '__exittest' was here
> > drivers/usb/host/ohci-ppc-soc.c:226: error: redefinition of 'cleanup_module'
> > drivers/usb/host/ohci-pci.c:260: error: previous definition of 'cleanup_module' was here
> > make[3]: *** [drivers/usb/host/ohci-hcd.o] Blad 1
> > make[2]: *** [drivers/usb/host] Blad 2
> > make[1]: *** [drivers/usb] Blad 2
> > make: *** [drivers] Blad 2
>
> Don't build ohci as module for now.
> A fix for that is already in gregkh usb tree for 2.6.21

We shouldn't have to wait for 2.6.21 to fix a known compilation
breakage. Greg, can you please push the fix to Linus quickly?

Thanks,
-- 
Jean Delvare
