Mime-Version: 1.0
Message-Id: <p04330100b64abb5a279d@[192.168.0.1]>
In-Reply-To: <3A24C62F.D69C7558@pop.agri.ch>
References: 
 <Pine.LNX.4.10.10011282036580.22745-100000@opal.biophys.uni-duesseld	
 orf.de> <p0433010ab649bafec687@[206.6.156.5]>
 <v04220800b64a66157aaa@[10.0.0.42]> <3A24C62F.D69C7558@pop.agri.ch>
Date: Wed, 29 Nov 2000 09:07:55 -0500
To: LinuxPPC-dev <linuxppc-dev@lists.linuxppc.org>
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: usb wheel mouse, XF4.0
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Well, then is there any way for any user to control how the
interrupts are dished out (assigned), say for example by moving cards
around in the slots? Can the kernel be patched to "hardwire" the
assignment of interrupts? (I'm talking a customs patch that only I
apply, not a general patch for everyone).

Or is this entirely an initialization problem deep in the kernel
code? Is there any timeline for fixing it or is it a part of the
longer-term PCI cleanup I've read about?

I am relatively limited in how I can move cards around as my earlier
post reporting my slot summary will attest to,

<http://lists.linuxppc.org/listarcs/linuxppc-dev/200011/msg00187.html>,


In addition, yesterday I speculated that the dual IRQ 23 might help
explain why I was having 2.2.18preX boot problems with the aic7xxx.
This can't really be the case because one of the slot summary tests
was to remove the USB card (and all others). There was no difference,
so my boot issue remains a separate one with its odd workaround.


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
