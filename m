Date: Wed, 20 Dec 2000 10:35:59 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Josh Huber <huber@mclx.com>
cc: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ethernet issue with lombard
In-Reply-To: <20001219220143.C6309@missioncriticallinux.com>
Message-ID: <Pine.LNX.4.10.10012201033160.23354-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> So, has anyone else had any problems with ethernet on their lombard?
> I was having trouble with 2.2.18, so I decided to try upgrading to
> 2.4.0-* (the 2_3 bk tree, as of this morning).  I thought the problem
> was fixed, but perhaps I didn't try long enough to break it.
>
> It seems to be easier to kill the network on a 10Mbit connection,
> rather than a 100Mbit connection.

I've seen problems recently with NFS over 100 Mbit - the server just
'disappears' for my Lombard. I'd say it's only in .18 because that's what
I use most of the time and I don't recall trouble in .17

> I can kill the network easily with ping -f <ip of local host>

I'll try that one then. No idea what causes it, and it's not really been
happening too often here.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
