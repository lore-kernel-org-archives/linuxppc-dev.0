Date: Mon, 22 Nov 1999 11:52:54 -0700
From: Cort Dougan <cort@ppc.kernel.org>
To: Dan Malek <dmalek@jlc.net>
Cc: Neil Blackwood <nb@terrafix.co.uk>, sorin@nitechinc.com,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: IDE on MBX board
Message-ID: <19991122115254.A29168@chimaera.ppc.kernel.org>
References: <99111909331400.01435@splash.nitechinc.com> <000a01bf34db$79773180$6401a8c0@everyone> <383975BE.A9B2A487@jlc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <383975BE.A9B2A487@jlc.net>; from Dan Malek on Mon, Nov 22, 1999 at 11:56:30AM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Would you mind using the stock 2.2.x from Linus?  Right now the current
patch level is 2.2.14pre7 from Alan.  It'll be easier to merge your patches
in for me if you work with that tree.

The problem I was having in the MBX IDE was much the same as you're seeing
now.  I couldn't find the drive.  One of the big problems was tracking down
the interrupt routing for IDE on the MBX.  If you check to see if you're
getting any interrupts at all on the 8259 that may give you a good place to
start.

I don't have an IDE drive for my MBX anymore but would like to have it
working again.  Let me know if you want to work together on it.

} That's a good point.....To follow up on my last message, if you want
} to try IDE on MBX, use a 2.2.x kernel that I have not updated :-).  That
} is, use the stuff in the CVS tree, not something I have as a tar
} image on ppc.kernel.org.
} 
} I really do want to get this correct.  It is likely to happen when
} I finish the pcmcia-cs for the 8xx, as that will use the standard IDE
} (with appropriate 8xx modifications) for the ATA Flash.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
