Subject: Re: Stability of network/io on MPC8540ADS?
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: Yuji Nishimura <yujin@pp.iij4u.or.jp>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <40A515E2.30401@pp.iij4u.or.jp>
References: <1084462045.4683.68.camel@lucy.pep-kaufbeuren.de>
	 <40A515E2.30401@pp.iij4u.or.jp>
Content-Type: text/plain
Message-Id: <1084776514.4828.6.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Date: Mon, 17 May 2004 08:48:34 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2004-05-14 at 20:54, Yuji Nishimura wrote:
> Helo Stefan,
>
> I evaluated MPC8540ADS and found out similar problem few weeks ago. I
> made tiny patch and it works well.
> I also evaluated with NEC ehci pci device. The result was fine.
> I wrote 1GB data to external usb-2.0 HDD via USB-2.0(ehci), that works well.
> I also try to use ftp(MPC8540=server) and transfer (R/W) 2047MB data via
> TSEC(gianfar) and it also works well.
> If you try to use this patch, please let me know. I think patch requires
> more evaluation...

Please send me the patch, althought I won't have time to
test it this week.

The funny thing is, that I got our self-build board working
partially by now, and in a very short test (<1min) it didn't
lock up (only the network, it doesn't have any PCI).
I'll keep an eye on it and maybe revisit those little
DIP-switches on the ADS...

Thanks,

--
Stefan Nickl
Kontron Modular Computers


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
