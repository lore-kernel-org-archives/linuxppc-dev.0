From: Jim Thompson <jim@musenki.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15529.2074.405979.113050@gargle.gargle.HOWL>
Date: Mon, 1 Apr 2002 19:23:38 -0600
To: caokai <tk19@taikebj.com.cn>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: where is the pci ethernet card's mac address?
In-Reply-To: <3CA9071B.BFA92915@taikebj.com.cn>
References: <3CA9071B.BFA92915@taikebj.com.cn>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


caokai writes:
>
> Hi
>     In my opinion,a pci ethernet card(intel eepro100)'s mac address
> should store somewhere in the PCI cards.

Normally in a small eeprom, yes.

> But in my EST8245 board,it seems the mac address is provided by the
> bsp(e.g EST VisionWare)?

Possible, but unlikely.

> So,if I run the linux without the VisonWare.It have a mac address
> 00:00:00:00:00:00:00.

Which, for recent versions of the kernel, will get you exactly
nowhere.  (In my experience the kernel will refuse to respond to ARP
requests for its address(es) if the requested IP address has an
associated all-zeros MAC address.

>      I am confusion now.Any advice?

Use the source, Luke.

--
"...the neurotic has problems, the psychotic has solutions." --Thomas Szasz


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
