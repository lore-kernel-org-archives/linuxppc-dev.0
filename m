Message-ID: <16694.138.89.83.168.1069733893.squirrel@www.opqua.com>
Date: Mon, 24 Nov 2003 23:18:13 -0500 (EST)
Subject: routing performance w/embedded linux on ppc?
From: "linuxppc user" <linuxppc@opqua.com>
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Folks,

There seems to be a plethora of data regarding linux IP routing
performance (e.g., forwarding rate in packets per sec) on x86
platforms.  This is likely because x86 boxen are all that typical
university students have in front of them.  :*)

I'm looking for some papers, pointers, or whatever regarding linux
routing performance on midrange embedded ppc hardware, for example
the moto8245 and ibm405GP (as used inside the Xilinx Virtex II Pro).

Basically our application boils down to a 4 port router, and we'd
like to get a handle on what kind of aggregate throughput and pps
we would be able to handle using these types of ppc processors at
~266/300 MHz.  Yes, the 8260, and 7xx, et al, are faster, but our
equipment cost profile is very restrictive.

example config:

  i82559 | <- PCI -> [mpc8245 @ 300MHz]
  i82559 |
  i82559 |
  i82559 |

There is other stuff hanging off of PortX and so forth, but that's
what the datapath looks like.

Thanks for any leads/hints/ideas/etc.  I'll summarize back.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
