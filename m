Date: Thu, 7 Oct 1999 16:06:48 +0200 (MET DST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Michel Lanners <mlan@cpu.lu>
cc: ran@krazynet.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: busmaster/latency for video
In-Reply-To: <199910071350.PAA00412@piglet.cpu.lu>
Message-ID: <Pine.GSO.4.10.9910071606120.24804-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 7 Oct 1999, Michel Lanners wrote:
> On   6 Oct, this message from Ryan Nielsen echoed through cyberspace:
> > PCI_COMMAND_MASTER is not enabled and latency = 0 for the ultimate rez video card, and pci_write_config_*
> > do not change them. latency = 32 and mastering is enabled for all the other cards in the machine,
> > 
> > should they be enabled ?
> 
> That probably means the card doesn't support them.
> 
> Normal graphic cards have no need for mastership. Only those with video
> inputs need it, in order to transfer video data into the framebuffer
> without CPU help.

Many recent graphics chips to support bus mastering, especially the AGP ones.

Greetings,

						Geert

--
Geert Uytterhoeven ----------------- Sony Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint Stevens Woluwestraat 55
Phone +32-2-7248632 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
