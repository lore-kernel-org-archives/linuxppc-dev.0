Message-ID: <3FA8536A.6080101@embeddededge.com>
Date: Tue, 04 Nov 2003 20:33:30 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: shanggao <shangg@dspchina.com>
Cc: Chris Simmonds <chris@2net.co.uk>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCI for mpc8270
References: <3FA7A8C5.2020702@2net.co.uk> <008b01c3a339$5ddc7c20$4b01a8c0@shang>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


shanggao wrote:

> If  mpc8270 has 60x bus,I think you can use CPC710,MV64361....................

The 8270 has the internal PCI bridge, like the 8265/66.
The linuxppc_2_4_devel kernel has the PCI functions and setup
for the 8266 on the Motorola ADS board.  It would be a
starting point for you.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
