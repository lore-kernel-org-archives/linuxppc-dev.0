Date: Thu, 18 Feb 1999 10:03:43 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: Jesper Skov <jskov@cygnus.co.uk>
cc: Gabriel Paubert <paubert@iram.es>,
        Christian Zankel <zankel@tarantel.rz.fh-muenchen.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Restructuring Efforts
In-Reply-To: <oovhh0w16z.fsf@lassi.cygnus.co.uk>
Message-ID: <Pine.LNX.3.96.990218100142.6024A-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I was just trying this out with tlbia: Use real tlbias in the kernel even
on chips that don't do tlbia.  When on a chip that doesn't have the tlbia
instruction take the trap and fix the code up in the trap handler (put in
a bl soft_tlbia instead of a tlbia).  We could do something like this per
architecture.  When doing an arch specific function trap, take the trap
and fix it up.  The problem with that is keeping track of the myriad of
functions we need to keep track of.

}It may be the case that none of the Amiga drivers use the same IO
}macros as other drivers use. As I remember it, there are two set of
}macros. But it's a long time since I looked at that, I could be wrong.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
