Subject: Re: GT64260_eth (Ethernet) Driver
From: David Woodhouse <dwmw2@infradead.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Dieu Morales <dieumorales@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org,
	Brian Waite <waite@skycomputers.com>
In-Reply-To: <40DCA1A3.6000401@mvista.com>
References: <20040620202719.25741.qmail@web60407.mail.yahoo.com>
	 <40DA06BE.204@mvista.com>
	 <1088066228.18627.3352.camel@hades.cambridge.redhat.com>
	 <40DB2199.2050006@mvista.com>
	 <1088147437.4636.114.camel@imladris.demon.co.uk>
	 <40DCA1A3.6000401@mvista.com>
Content-Type: text/plain
Message-Id: <1088207000.4636.136.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Date: Sat, 26 Jun 2004 00:43:20 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2004-06-25 at 15:05 -0700, Mark A. Greer wrote:
> Would you mind looking at the code, giving me feedback ("this totally
> sucks and needs to be thrown out" is perfectly valid) and looking for
> things I may have missed?

For one, pci_auto sucks and needs to be thrown out. If the generic Linux
PCI resource assignment is broken, fix it rather than reimplementing it.
I'd also like to ditch the typedefs (use struct mv64x60_setup_info
instead of mv64x60_setup_info_t etc.).

Further than that I haven't noticed much yet -- my Friday ended before I
got the machine to boot. I think I relocated the chip to the wrong
address, because first the memory probe returned zero and then the PCI
idents were all 0xFFFF. I'll play some more on Monday.

Thanks for the pointers.

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
