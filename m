From: Alan Cox <alan@cymru.net>
Message-Id: <199901142052.UAA24588@snowcrash.cymru.net>
Subject: Re: Synchronization [was Re: The Magic Show: kernel_map() disappearing]
To: jskov@cygnus.co.uk (Jesper Skov)
Date: Thu, 14 Jan 1999 20:52:51 +0000 (GMT)
Cc: cort@persephone.cs.nmt.edu, linuxppc-dev@lists.linuxppc.org,
        Jes.Sorensen@cern.ch, alan@cymru.net, linux-apus@sunsite.auc.dk
In-Reply-To: <13981.45420.95483.559227@lassi.cygnus.co.uk> from "Jesper Skov" at Jan 14, 99 08:57:16 am
Content-Type: text
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  eieio: prevent CPU from reordering/collapsing reads/writes to memory.
>         (but otherwise run at full steam!)

Thats what mb() does - its a memory-barrier hence the name - it imposes
strong store ordering properties across it. 

> That's why I added the iobarrier() macros (adding _w/_r/_rw on Alan's
> request) that are only related to IO synchronization within the same
> CPU. Essentially it's just renaming the eieio() macro already used in
> many PPC drivers because it's a bad name; Linux/APUS will be sharing
> drivers with Linux/m68k where eieio isn't such a helpful name.

Yep.

x86 and most other processors dont have the notion of a store barrier and
an i/o barrier beign different

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
