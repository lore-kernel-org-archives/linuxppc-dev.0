Date: Wed, 19 Jul 2000 16:03:31 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: William Blew <wblew@home.com>
cc: Nathan Ingersoll <ningerso@d.umn.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Malloc bug?
In-Reply-To: <Pine.LNX.4.10.10007190929270.762-100000@apollo.kulian.net>
Message-ID: <Pine.LNX.3.96.1000719160107.2600D-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 19 Jul 2000, William Blew wrote:

> On Tue, 18 Jul 2000, David A. Gatwood wrote:
>
> Anybody know here man page patches are submitted? After all, if the
> man page is incorrect, an easy fix is to update it :).
>
> BTW: David, thanks for the info.

No prob.  And Hollis made another good point about running past the bounds
of a memory region.  Same applies for any data structure (arrays, etc.).
Another common problem is to compile against a set of headers for a
library where the library itself doesn't match.  This can cause the size
of objects to change, and you run over the bounds without even knowing it.


David

---------------------------------------------------------------------
A brief Haiku:

Microsoft is bad.
It seems secure at first glance.
Then you read your mail.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
