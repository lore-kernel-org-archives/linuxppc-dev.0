Date: Tue, 29 Dec 1998 17:36:49 -0500 (EST)
From: Tom Rini <tmrini@ntplx.net>
To: Andreas <a.tobler@schweiz.ch>
cc: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: Re: imake & pre-5
In-Reply-To: <36891198.A0420225@schweiz.ch>
Message-ID: <Pine.LNX.4.05.9812291734580.1058-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 29 Dec 1998, Andreas wrote:

> After the install I tried to recompile the sources I had from a
> previous download.  A simple make of a package abc worked, but when I
> tried to rpm -bc xyz I got a segmentation fault made by imake. (and a
> core dump). Up to now I wasn't able to localize where imake.c is in.  

rpm -q XFree86-devel .  I think you have 3.3.3-10b (known to be broken,
get the new one, 10d)

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
