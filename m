Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <1084776514.4828.6.camel@lucy.pep-kaufbeuren.de>
References: <1084462045.4683.68.camel@lucy.pep-kaufbeuren.de> <40A515E2.30401@pp.iij4u.or.jp> <1084776514.4828.6.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <236747C3-A84B-11D8-A8A3-000393DBC2E8@freescale.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>,
	Yuji Nishimura <yujin@pp.iij4u.or.jp>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: Stability of network/io on MPC8540ADS?
Date: Mon, 17 May 2004 16:42:47 -0500
To: Stefan Nickl <Stefan.Nickl@kontron.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stefan,

I've pushed the bug fix from Yuji and a number of other changes to the
linuxppc-2.4 bitkeeper tree.  Please note that this change requires an
updated u-boot due to memory map changes.  The patches exist on the
u-boot list from Jon Loeliger.  I'm not sure if they have yet made it
into u-boot CVS for the MPC8540/60 ADS boards.

If you have any other issues let me know.

- kumar

On May 17, 2004, at 1:48 AM, Stefan Nickl wrote:

>
> On Fri, 2004-05-14 at 20:54, Yuji Nishimura wrote:
>> Helo Stefan,
>>
>> I evaluated MPC8540ADS and found out similar problem few weeks ago. I
>> made tiny patch and it works well.
>> I also evaluated with NEC ehci pci device. The result was fine.
>> I wrote 1GB data to external usb-2.0 HDD via USB-2.0(ehci), that
>> works well.
>> I also try to use ftp(MPC8540=server) and transfer (R/W) 2047MB data
>> via
>> TSEC(gianfar) and it also works well.
>> If you try to use this patch, please let me know. I think patch
>> requires
>> more evaluation...
>
> Please send me the patch, althought I won't have time to
> test it this week.
>
> The funny thing is, that I got our self-build board working
> partially by now, and in a very short test (<1min) it didn't
> lock up (only the network, it doesn't have any PCI).
> I'll keep an eye on it and maybe revisit those little
> DIP-switches on the ADS...
>
> Thanks,
>
> --
> Stefan Nickl
> Kontron Modular Computers
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
