Message-ID: <DF2142DFD5ECD311BA1900104B943A979321CF@roche-exg1.rochester.adaptivebroadband.com>
From: "Ruhland, Paul" <pruhland@microwavedata.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: [linuxppc-embedded] PCMCIA on MBX860
Date: Mon, 20 Nov 2000 17:18:52 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've had zero success compiling the pcmcia-cs-3.1.19 card services package
for an MBX860 board.

Using:
    mVista hardhat kernel 2.2.14
    mVista hardhat cross compiler

Its choking in 'modules/i82365.c' with the following error:

     #error "no bus architectures defined!"

>From this, I figured I needed to include either PCI or ISA support in my
kernel config.  However, enabling QSpan PCI in kernel configuration yields
errors during kernel build.

Has anyone gotten the card services to work on an MBX board?

----------------------
Paul Ruhland


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
