Subject: Re: PPC4xx enet driver problem (version 2.0)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: DaveyWu <daveywu@transengines.com>
Cc: Stefan Roese <stefan.roese@esd-electronics.com>,
	"'Linuxppc-Embedded'" <linuxppc-embedded@lists.linuxppc.org>,
	akuster@mvista.com
In-Reply-To: <005201c3c224$135c4090$5100a8c0@davey033ce6193>
References: <004601c3c09e$8cfea410$0212000a@PCSTEFAN>
	 <005201c3c224$135c4090$5100a8c0@davey033ce6193>
Content-Type: text/plain
Message-Id: <1071446151.12499.394.camel@gaston>
Mime-Version: 1.0
Date: Mon, 15 Dec 2003 10:55:52 +1100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sun, 2003-12-14 at 20:24, DaveyWu wrote:
> Stefan,
>
> Thanks for your reply. My bootloader is OpenBios. I think the problem is not caused by the wrong MAC addresses, because when I boot the 2.4.18 kernel the MAC address of eth1 is same 00:00:00:00:00:00 but both EMACs work well.
>
> Our engin

Hrm... I doubt a MAC of 00:00:00:00:00:00 works properly

Ben.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
