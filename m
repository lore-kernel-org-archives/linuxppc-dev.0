Subject: Re: IRQS on 6 Slot Macs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mich Lanners <mlan@cpu.lu>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <E1AGmH5-0000CV-00@piglet.grunz.lu>
References: <E1AGmH5-0000CV-00@piglet.grunz.lu>
Content-Type: text/plain
Message-Id: <1067915818.17970.66.camel@gaston>
Mime-Version: 1.0
Date: Tue, 04 Nov 2003 14:16:59 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Sure, but it's indeed totally not understandable why they didn't use the
> other lines on GrandCentral, since the 9500/9600 design includes six PCI
> slots with each a dedicated IRQ line. Weird...

Probably because updating Apple's 1.0.5 OF code to assign them properly
with the P2P setup was beyond their ability to deal with crappy code :)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
