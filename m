Date: Tue, 9 Mar 1999 16:31:31 -0500 (EST)
From: Tom Rini <tmrini@ntplx.net>
To: "Charles E. Leiserson, Jr." <locutus@MIT.EDU>
cc: Hollis R Blanchard <hollis+@andrew.cmu.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: No-IDE kernel compile link errors 
In-Reply-To: <199903091638.LAA14811@all-night-tool.mit.edu>
Message-ID: <Pine.LNX.4.05.9903091629070.2274-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 9 Mar 1999, Charles E. Leiserson, Jr. wrote:

> I seem to recall having read something about the 2.2 kernels not compiling if 
> IDE isn't set.  I had the same problem, so I just compiled in IDE support, 
> even though I have no IDE devices or bus.
> 
> Feel free to correct me if I'm wrong.

Please try
ftp://linuxppc.cs.nmt.edu/pub/linuxppc/patches/non-pmac-ide/ide.diff
Then rm your .config and try again.  If this works I'll bug Cort <g>

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
