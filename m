Message-ID: <3D6797F8.4000106@embeddededge.com>
Date: Sat, 24 Aug 2002 10:28:08 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: acurtis@onz.com,
	Ppc Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 8260 Memory Management
References: <3D65C19C.2070503@embeddededge.com>	<NCBBIINEHIPFGJPLBEIFAEBNDLAA.acurtis@onz.com> <15718.52527.24904.317204@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paul Mackerras wrote:

> Dan, can we *please* take out the #define request_irq request_8xxirq
> and just use request_irq like everyone else?

I was doing that as part of the 2.5 interrupt changes, but if you
want to do it now we can try.  On the 8260 it's not as bad as the 8xx,
but you have to ensure the legacy and PCI interrupts are outside of
the internal controller and CPM ranges.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
