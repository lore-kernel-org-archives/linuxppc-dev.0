Date: Sun, 21 Feb 1999 11:28:46 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: Johnnie Peters <jpeters@phx.mcd.mot.com>
cc: Gabriel Paubert <paubert@iram.es>, Jeremy Fitzhardinge <jeremy@goop.org>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Interrupt routing in prep_pci.c
In-Reply-To: <36D03ACA.F8626298@phx.mcd.mot.com>
Message-ID: <Pine.LNX.3.96.990221112659.2159A-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


It doesn't work many of the boards I have.  The residual data isn't
always there and isn't always right when it is there.  The comment about
it going away soon was referring to the code to use residual data - but it
turns out that we can't always depend on it.  I still don't like the way
we do it, though.

}> > Rather than having hard-coded tables, can't the interrupt routing be determined
}> > from either firmware or the interrupt controller itself?  The comment at the
}> > top of the file is that this will go away soon.  What are you planning to
}> > replace it?
}>
}> Indeed, that's what I do from residual data on PreP machines and it seems
}> to work on several kinds of boards. You'll find it embedded somewhere
}> in the patch file at:


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
