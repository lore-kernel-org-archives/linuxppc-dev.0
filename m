Message-ID: <3691A41B.5BB09E15@jlc.net>
Date: Tue, 05 Jan 1999 00:33:15 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Cort Dougan <cort@persephone.cs.nmt.edu>
CC: Paul Mackerras <paulus@cs.anu.edu.au>,
        Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>,
        bh40@calva.net, tmrini@ntplx.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: irq cleanup
References: <Pine.LNX.3.96.990104184703.27992A-100000@persephone.cs.nmt.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Cort Dougan wrote:

> Right, that's the plan.
>
> }To support PCI or ISA devices that interrupt on the MBX
> }you would need to modify irq.c to support a multilevel interrupt
> }scheme.  The 8259 would interrupt on one of the 8xx interrupt
> }controller levels, then you would have to process all 8259
> }interrupts.


Are there other systems designed like this with a multilevel
interrupt controller?  It's not hard to imagine, although I have
never seen one before the MBX.  This is one reason I didn't
spend any effort when I did the iniitial port.  It seemed like
lots of work for a single board not likely to use them

    -- Dan



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
