Date: Fri, 12 Nov 1999 21:49:44 +0100 (CET)
From: Michael Schmitz <schmitz@simul.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.3.27 on CHRP Longtrail
In-Reply-To: <19991112172003.001697@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.10.9911122147590.22175-100000@simul.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Basically, that means that it's possible to display debugging text from
> almost every point of the kernel initialisation (using mostly
> xmon_printf) before the fb is up and running, even while OF output can no
> more be used (after MMU init).
> 
> It's too hackish for now, and I have no time to post a patch before later
> today or this week end, I'll try to clean this a little bit and separate
> it from the main bunch of iBook patches since i could be useful for
> others too.

Please do. I tried to use xmon_printf for this very purpose on my Lombard
with 2.3.13 with no success. 

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
