Date: Mon, 8 May 2000 01:47:15 -0400
From: Daniel Jacobowitz <drow@false.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: problem with Makefile
Message-ID: <20000508014714.A19467@drow.res.cmu.edu>
References: <01ec01bfb8ad$e8888fa0$bf0102c8@dell191.sc.mcel.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <01ec01bfb8ad$e8888fa0$bf0102c8@dell191.sc.mcel.mot.com>; from rolfl@sc23.sc.mcel.mot.com on Mon, May 08, 2000 at 01:26:05PM +0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, May 08, 2000 at 01:26:05PM +0800, Rolf Liu wrote:
>
> Hi, all,
> You know, the current Makefile for linux-ppc is based on linux shell.My
> current work
> is to translate the Makefile of linux-ppc into a standard one, such as one
> for windows-based
> Makefile,which is meaningful to other standard "make" utilities,including
> the Borland make ,and
> the Microsoft make.If anyone had such experience , advice is appreciate.
> Thanks.

Ummm... what do you mean?

There is a standard make.  It's POSIX, I believe.  The linux makefile
is pretty close to it.  Why on earth would you want to use Microsoft or
Borland tools (which are nmake, not make, IIRC) to build a kernel?

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
