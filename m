Message-ID: <397517B2.8F22EDEA@amulet.co.jp>
Date: Wed, 19 Jul 2000 11:51:30 +0900
From: Hollis Blanchard <hollis@amulet.co.jp>
MIME-Version: 1.0
To: Nathan Ingersoll <ningerso@d.umn.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Malloc bug?
References: <Pine.SO4.4.02.10007181457570.7001-100000@ub.d.umn.edu>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Nathan Ingersoll wrote:
>
> I've been working on a GTK program for a while now, and I've been
> experiencing segfaults within malloc.

In my experience this is almost always caused by overwriting array
bounds somewhere before that. (Learning how malloc works helps you
understand why.) Go check all your memory accesses. Electric Fence might
help.

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
