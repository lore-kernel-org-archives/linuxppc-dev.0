Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Thu, 7 Feb 2002 19:24:02 -0600 (CST)
From: Viktor Lapinskii <lapinski@pacific.ece.utexas.edu>
Reply-To: lapinski@ece.utexas.edu
To: linuxppc-embedded@lists.linuxppc.org
Subject: kernel debugging in MontaVista Journeyman 2.0
Message-ID: <Pine.A41.4.44.0202071800550.13790-100000@pacific.ece.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

We have Motorola Sandpoint with PPMC8240 and MontaVista Journeyman 2.0.
Budget constraints do not allow us to have a full version of MontaVista
Linux and I am trying to find some ways to do kernel debugging with the
Journeyman version of linux-2.4.2_hhl20.

We need to perform some measurements on a network card driver.  Ideally,
it would be great to obtain executuion traces (on the machine instruction
level) of different components of that driver (eventaully with timestamps)
and also (probably indirectly) measure DMA exchanges between the network
card and RAM.  Setting breakpoints is also desirable.

Journeyman apparently does not have KGDB support and I would highly
appreciate your advice on how such measurements / trace construction can
be done (besides using occiloscope or printouts and pencil).  It's the
first time I am trying to get deep into the kernel so any of your
suggestions/references would be very helpful.

Thank you,

Viktor


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
