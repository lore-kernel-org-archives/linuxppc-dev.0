From: Alan Cox <alan@cymru.net>
Message-Id: <199901150138.BAA30172@snowcrash.cymru.net>
Subject: Re: Synchronization [was Re: The Magic Show: kernel_map() disappearing]
To: cort@persephone.cs.nmt.edu (Cort Dougan)
Date: Fri, 15 Jan 1999 01:38:48 +0000 (GMT)
Cc: alan@cymru.net, jskov@cygnus.co.uk, linuxppc-dev@lists.linuxppc.org,
        Jes.Sorensen@cern.ch, linux-apus@sunsite.auc.dk
In-Reply-To: <Pine.LNX.3.96.990114145156.7359A-100000@persephone.cs.nmt.edu> from "Cort Dougan" at Jan 14, 99 02:53:11 pm
Content-Type: text
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> That's my rationale for doing the sync and eieio in the mb().  That way,
> we're guaranteed no races no matter what assumptions someone makes about
> the x86 when adding barriers to their driver code.  Is that unreasonable?

It would be good to get the right stuff done in the drivers not take a
wired in performance hit we cant get back out of

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
