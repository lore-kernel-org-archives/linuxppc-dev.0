Message-Id: <199912192122.PAA07133@sun92.texmemsys.com>
Date: Sun, 19 Dec 1999 15:22:27 -0600 (CST)
From: Jonathan Brauer <brauer@texmemsys.com>
Reply-To: Jonathan Brauer <brauer@texmemsys.com>
Subject: Arp addresses
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This question might be better posted to the general mailing list, but I though I 
would try here first.

After completing the *writing* of the custom network driver for our PPC port I 
seem to have run into a prick wall with the arp workings.  After using ifconfig 
to configure the eth0 device I attempt to ping the device.  The ethernet seems 
to pass the packet up and into the arp_rcv function, but in hear, the arphdr 
arp_hln and arp_pln seem to have not been configured correctly.  Does anyone 
know where in an rx skbuff in 2.2.13 that the arphdr structure is initialized?

I imagine it might very well be a configuration or missing binary file, but I 
honestly can not seem to gleem where this occurs in the kernel code.  A grep on 
arphdr and arp_hln does not seem to reveal this.

Jonathan Brauer
Texas Memory Systems


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
