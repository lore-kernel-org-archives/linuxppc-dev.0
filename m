Date: Mon, 7 Dec 1998 14:03:26 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org, Cort Dougan <cort@ladron.cs.nmt.edu>,
        Paul Mackerras <paulus@cs.anu.edu.au>
Subject: Re: L2CR patch
In-Reply-To: <19981207132230.001760@mail.mipsys.com>
Message-ID: <Pine.LNX.3.96.981207140252.5961A-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This looks good.  Has there been success in trying it out
(enabling/disabling the cache)?

}Enclosed is a patch that replace the _set_L2CR function in the kernel by
}a new version that is safer (does the appropriate flushing etc... when
}enabling the cache).


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
