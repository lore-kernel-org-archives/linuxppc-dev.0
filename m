Date: Thu, 31 Dec 1998 15:48:08 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: grackle, patches, MMU, ...
In-Reply-To: <19981231232453.013798@smtp.calvacom.fr>
Message-ID: <Pine.LNX.3.96.981231154708.14805A-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


It'd be nice to have the BATs be a flexible commodity but how to do that
isn't clear.  If we can have a clean mechanism for doing it (much like
superpages) we can generalize it to the 8xx chips as well.

}Ok. I knew for the variable number of BATs. So currently, the BATs are
}set once


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
