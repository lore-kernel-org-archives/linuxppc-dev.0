Message-ID: <383AD74B.1533E154@netx4.com>
Date: Tue, 23 Nov 1999 13:04:59 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Francois Guimond <fguimond@pplmail.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux ppc newbie boot sequense
References: <383993F5.BCE4A507@pplmail.com> <3839CADC.CCDB6C7E@jlc.net> <383ABADB.8DDDA110@pplmail.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Francois Guimond wrote:


> What have you got?

An 8240/Sandpoint that will boot up using a PCI Ethernet card
and will use an NFS root file system.  The console doesn't work
properly because I didn't finish the 8259 interrupt controller
code.  You can start up Apache, inetd, and do everything over
the network.

I'll try to get it checked into the latest 2.3.xx source tree
(it is based on 2.3.16) over our Thanksgiving holiday weekend.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
