Date: Tue, 9 Mar 1999 10:05:40 -0500 (EST)
From: Tom Rini <tmrini@ntplx.net>
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
cc: "G. [iso-8859-1] Laurs" <laures@hp1.esiea.fr>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: No-IDE kernel compile link errors
In-Reply-To: <Pine.LNX.3.96L.990309092723.1664A-100000@unix47.andrew.cmu.edu>
Message-ID: <Pine.SUN.4.02.9903091000001.15788-100000@sea.ntplx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 9 Mar 1999, Hollis R Blanchard wrote:

 However, since I really don't want anything to do with IDE in my
kernel, I'll
> hope this gets taken care of - or do the NMT patches mentioned fix it? FWIW, I
> got my sources from NMT (the 3/7 vger snapshot).

The NMT snapshots are just what's in vger.  This patch is not.  Goto the
patch/pmac-ide-module or ide-module dir, grab that and try again.  I
think this is the same thing I ran into when I was running the iMac w/
nfsroot and had ide modularized for fun.

--
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
