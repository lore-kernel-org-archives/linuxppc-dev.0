Message-ID: <E1836A7F3557D311A14000805F9F36FC0141C784@usdfo011.usac.danfoss.net>
From: Hihn Jason <JasonHihn@DANFOSS.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Software triggered DMA on 823e?
Date: Fri, 12 Jul 2002 19:06:06 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We're doing a design and due to the way some of our devices work, we want to
do a DMA transfer on an interrupt  from a peripheral. My team is wondering
if we can write a interrupt handler that will initiate the DMA xfer without
having to use external pins, or if we have to route an output pin to DREQ
and trigger it that way.

Our peripheral is a memory mapped device, but it's only a buffer. We need to
catch its interrupt and DMA the buffer out to a place for our application to
handle it.

We've been all over the manual and can't find the answer.
Any help is appreciated.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
