Date: Fri, 15 Jan 1999 12:28:17 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: Alan Cox <alan@cymru.net>
cc: Paul.Mackerras@cs.anu.edu.au, jskov@cygnus.co.uk,
        linuxppc-dev@lists.linuxppc.org, Jes.Sorensen@cern.ch,
        linux-apus@sunsite.auc.dk
Subject: Re: Synchronization [was Re: The Magic Show: kernel_map() disappearing]
In-Reply-To: <199901151610.QAA16497@snowcrash.cymru.net>
Message-ID: <Pine.LNX.3.96.990115122713.10155A-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Then my paranoid use of sync can go away, and we can stick with eieio as
long as we have the "memory" marked changed in the linline asm.  Sound
good to everyone?

}	rmb()	Do not re-order reads across this point (CPU or compiler)
}	wmb() 	Do not re-order writes across this point (CPU or compiler)
}	mb()	Do not re-order reads or write across this point



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
