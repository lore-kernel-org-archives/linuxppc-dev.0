Date: Sun, 9 May 1999 15:24:13 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: Erik Karlberg <flash@sdf.nu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: $OSTYPE
In-Reply-To: <Pine.BSF.4.05.9905091956030.48121-100000@mj0lkchoklad.sdf.nu>
Message-ID: <Pine.LNX.4.05.9905091522560.654-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 9 May 1999, Erik Karlberg wrote:

> 
> On Sun, 9 May 1999, Tom Rini wrote:
> > Mostly applied :) (AMD and cyrix get labeled intel it looks like, so the
> > non-apple pmacs and other ppcs can be called apple, unless someone has a
> > better idea)
> 
> I guess the intel-label of the AMD and Cyrix processors kind of resembles
> intel-compatibility or somthing like that...
> So labeling all ppc-machines apple might not be such
> a great idea, since it is not Apple alone who's behind the ppc..

Apple is the biggest "vendor" tho (of 6xx/7xx ppcs).  It doesn't really
matter as most config scripts are *-linux-gnu-* or so, so having OSTYPE
mklinux would be bad (if a script should check that way).

> How about labeling it aim? (Apple IBM Motorola)
> However, that might be a bit confusing for those who doesn't know what it
> mean...

Exactly..

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
