Date: Thu, 14 Jan 1999 14:53:11 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: Alan Cox <alan@cymru.net>
cc: Jesper Skov <jskov@cygnus.co.uk>, linuxppc-dev@lists.linuxppc.org,
        Jes.Sorensen@cern.ch, linux-apus@sunsite.auc.dk
Subject: Re: Synchronization [was Re: The Magic Show: kernel_map() disappearing]
In-Reply-To: <199901142052.UAA24588@snowcrash.cymru.net>
Message-ID: <Pine.LNX.3.96.990114145156.7359A-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


That's my rationale for doing the sync and eieio in the mb().  That way,
we're guaranteed no races no matter what assumptions someone makes about
the x86 when adding barriers to their driver code.  Is that unreasonable?

}x86 and most other processors dont have the notion of a store barrier and
}an i/o barrier beign different



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
