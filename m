Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3B7D8268.5060902@mvista.com>
Date: Fri, 17 Aug 2001 13:45:28 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Liu HongXun-a16975 <a16975@motorola.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Is there a PCI based 802.11b device driver for ppc linux?
References: <01139FC052A0D411900B00508B9535FC02A9CA76@ZCH07EXM04.corp.mot.com> <20010817131403.G556@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

> On Fri, Aug 17, 2001 at 11:11:28AM +0800, Liu HongXun-a16975 wrote:
>
>> Hi, all,
>> Our customized ppc based board only has PCI interface. I wonder if there is a PCI based 802.11b device driver for ppc linux?
>
>
> Well, it depends on the chipset.  And is it a PCI one or a pcmcia one in a
> pcmcia pci card.  I think some of the prism II and whatnot based cards work.
> Take a look in drivers/net/wireless.
>

Both the prism II and Cisco PCI cards have device drivers.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
