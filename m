Date: Thu, 9 Mar 2000 08:31:10 -0800 (PST)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
cc: Gabriel Paubert <paubert@iram.es>, Kostas Gewrgiou <gewrgiou@imbc.gr>,
        Michel Danzer <michdaen@iiic.ethz.ch>, linuxppc-dev@lists.linuxppc.org
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work on pp  cwith r128
In-Reply-To: <v03110700b562a526cc14@[129.100.29.243]>
Message-ID: <Pine.LNX.3.96.1000309082908.3748C-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 6 Jun 2000, Kevin B. Hendricks wrote:

> >> 3. 601 processors may barf(?) on some of these instructions.
> >
> >No, it does not. It's just that the cache is unified which makes most
> >coherency functions irrelevant.
>
> So 601's have no problems with sync and isync, just eieio?  AFAIK, there is
> some code snippet in the kernel that somehow works around a 601 problem
> with one of the synchronization instructions but I don't remember which one
> right off hand.

There's a bug on certain cards in x100-land that makes them crash on
sync() and eieio().  isync() is irrelevant on a 601, since there's not a
separate instruction cache.

I can only assume that this is what the original poster meant.


Later,
David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
