Subject: PCI scanning and devices initialization
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF8D823500.2A30CF0C-ONC1256EF4.0040DDB4@uk.marconicomms.com>
From: "Stefano Gaiotto" <Stefano.Gaiotto@marconi.com>
Date: Wed, 18 Aug 2004 13:52:08 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear colleagues,

I'm trying to use a device connected to a PCI bus, more exactly a
PCI/PCMCIA bridge
with u-boot-1.1.1 and Linux (2.4.24 and 2.6.8) in a board with MPC8270.

Both u-boot and Linux, during scanning procedure show me only the PCI
bridge [1057/18c0] but I can't see the devices connected to the bus.

I'm a novice with PCI bus and I'm not sure the board is good (is the first
prototype) and so I'd like to know if scanning procedure should tell me the
devices
connected or I have to do some device initialization before I can see them
during scanning.

I suppose I should see them during scanning and then initialise them via
PCI bus.

If my assumption is true, shall I suppose my hardware is not good? Or
anything else?

Thank you for your attention

Regards,
      Stefano


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
