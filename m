Date: Mon, 22 Feb 1999 12:26:17 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: VALETTE Eric <valette@crf.canon.fr>
cc: jpeters@phx.mcd.mot.com, paubert@iram.es, jeremy@goop.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Interrupt routing in prep_pci.c
In-Reply-To: <m10EzkG-0000WXC@tri-yann.crf.canon.fr>
Message-ID: <Pine.LNX.3.96.990222122334.5504A-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


It's not as simple as you suggest.  Code it up so that it works on all
the boards around and I'll be quite happy to take it :)  The problem
I'm having now is code that works on one set doesn't work on others.

I don't want to break the kernel for older boards just because you can't
buy them anymore.  That's not a reason to ignore them.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
