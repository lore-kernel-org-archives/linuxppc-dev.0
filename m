Message-ID: <39CBAA3C.2CC16A34@wanadoo.fr>
Date: Fri, 22 Sep 2000 20:51:40 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
CC: Benjamin Herrenschmidt <benh@mipsys.com>
Subject: Re: Re; 2.4.0-test9 on B&W G3
References: <20000922164705.32547@mail.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> >I have also been seeing the same old 'lost interrupt' problem when trying
> >to boot a B&W G3 using the latest yaboot (0.8) on the latest pmac-devel
> >rsync kernel.  I was wondering if this was a know bug with the latest 2.4
> >tree kernel's.  I also booted the same kernel on a new G4/450 with no
> >problems.
>
> I have a fix for that too. I'll push it as soon as I have access to bk again.
> In the meantime, apply enclosed changeset to the current linuxppc_2_3 bk tree.

Glad to hear that the linuxppc_2_3 bk tree is not dead. I was just going
to ask about it, because since 2 weeks it has remained at -test8 which
is feared for its terrible mailbox-eating habits.

On the other hand, I am running a kernel obtained from this tree by
applying just the "official" test9-pre1 patch, and I have now an uptime
of 4 days, 22:02. This is the longest uptime I ever had with a 2.3/4
kernel. No spontaneous freezes so far <knocking on wood>.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
