Date: Sat, 24 Jul 2004 09:50:41 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: confusion regarding UART config and source files
Message-ID: <Pine.LNX.4.60.0407240924590.12548@dell.enoriver.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


   i know this has come up before but, if i understand correctly, given
that UART support is moving from (at least in my case)
arch/ppc/8xx_io/uart.c to drivers/serial/cpm_uart, is there any need
to keep the

   [ ] Use UART

entry in the MPC8xx CPM Options menu?

   also, if one looks in drivers/serial/cpm_uart/Makefile, there's a
test for the CONFIG_CPM2 variable which doesn't seem to exist anymore;
certainly, a recursive grep doesn't show anything ever setting it,
and grep showed a few other files that test the apparently obsolete
CONFIG_CPM2.

rday

p.s.  and i assume that comment at the top of the cpm_uart/Makefile
that reads,

# Makefile for the Motorola 8xx FEC ethernet controller

is just one of those ubiquitous cut and paste glitches. :-)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
