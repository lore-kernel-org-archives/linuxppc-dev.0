From: "Bob Piatek" <bobtek@fishcamp.com>
To: "'Hihn Jason'" <JasonHihn@DANFOSS.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Software triggered DMA on 823e?
Date: Fri, 12 Jul 2002 11:50:07 -0700
Message-ID: <002501c229d4$f1744650$a2341204@P4>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <E1836A7F3557D311A14000805F9F36FC0141C784@usdfo011.usac.danfoss.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The chip definitely requires that the DREQ signal be used to start a DMA
transfer.  That is even if you are doing memory-to-memory transfers.

See section 16.6.3.7 in the Reference manual.

Bob

fishcamp engineering
105 W. Clark Ave
Orcutt, CA  93455
TEL: 805-937-6365
FAX: 805-937-6252


-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org] On Behalf Of Hihn
Jason
Sent: Friday, July 12, 2002 10:06 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Software triggered DMA on 823e?


We're doing a design and due to the way some of our devices work, we
want to
do a DMA transfer on an interrupt  from a peripheral. My team is
wondering
if we can write a interrupt handler that will initiate the DMA xfer
without
having to use external pins, or if we have to route an output pin to
DREQ
and trigger it that way.

Our peripheral is a memory mapped device, but it's only a buffer. We
need to
catch its interrupt and DMA the buffer out to a place for our
application to
handle it.

We've been all over the manual and can't find the answer.
Any help is appreciated.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
