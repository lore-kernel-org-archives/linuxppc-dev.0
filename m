Message-ID: <383975BE.A9B2A487@jlc.net>
Date: Mon, 22 Nov 1999 11:56:30 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Neil Blackwood <nb@terrafix.co.uk>
CC: sorin@nitechinc.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: IDE on MBX board
References: <99111909331400.01435@splash.nitechinc.com> <000a01bf34db$79773180$6401a8c0@everyone>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Neil Blackwood wrote:


> I have used this with MBX821 . It at least seems to see the disk during
> boot.
> I haven't tried partitioning it yet. It only seems to work on 2.2.5. Every
> kernel later seems broken

That's a good point.....To follow up on my last message, if you want
to try IDE on MBX, use a 2.2.x kernel that I have not updated :-).  That
is, use the stuff in the CVS tree, not something I have as a tar
image on ppc.kernel.org.

I really do want to get this correct.  It is likely to happen when
I finish the pcmcia-cs for the 8xx, as that will use the standard IDE
(with appropriate 8xx modifications) for the ATA Flash.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
