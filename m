From: Alan Cox <alan@cymru.net>
Message-Id: <199901151610.QAA16497@snowcrash.cymru.net>
Subject: Re: Synchronization [was Re: The Magic Show: kernel_map() disappearing]
To: Paul.Mackerras@cs.anu.edu.au
Date: Fri, 15 Jan 1999 16:10:47 +0000 (GMT)
Cc: alan@cymru.net, jskov@cygnus.co.uk, cort@persephone.cs.nmt.edu,
        linuxppc-dev@lists.linuxppc.org, Jes.Sorensen@cern.ch,
        linux-apus@sunsite.auc.dk
In-Reply-To: <199901150157.MAA01789@tango.anu.edu.au> from "Paul Mackerras" at Jan 15, 99 12:57:32 pm
Content-Type: text
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> was that it basically said "an interrupt or another processor might
> have changed memory, so don't keep values from memory cached in
> registers".  With wmb() on SMP, this seems to be extended to include
> "make sure other cpus can see the values we just wrote".  I don't know
> exactly how rmb() differs from mb().

	rmb()	Do not re-order reads across this point (CPU or compiler)
	wmb() 	Do not re-order writes across this point (CPU or compiler)
	mb()	Do not re-order reads or write across this point


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
