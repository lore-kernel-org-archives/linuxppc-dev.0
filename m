Message-Id: <200003200257.VAA26624@mal-ach.watson.ibm.com>
To: Gabriel Paubert <paubert@iram.es>
cc: Florian Lohoff <flo@rfc822.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: PPC/MCA RS/6000 port ? 
In-Reply-To: Message from Gabriel Paubert <paubert@iram.es>
   of "Mon, 20 Mar 2000 01:20:32 +0100." <Pine.HPX.4.10.10003200116330.28648-100000@gra-ux1.iram.es>
Date: Sun, 19 Mar 2000 21:57:45 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	I do not have any hardware specs for these machines offhand, but
the interrupt controller may very well be PC-like cascaded 8259s.

	The PPC601 was a POWER architecture chip with additional user-mode
PowerPC instructions.  It was based on the existing RSC (RIOS Single Chip)
processor that IBM already was using and allowed the first PowerPC chip
implementation to be developed and deployed very rapidly.  The supervisor
state of the chip was all POWER architecture, not PowerPC Books II and
III.  The direct store segments were a way to access special devices on
the I/O bus.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
