In-Reply-To: <19990106044123.C377@chippewa.telecom.ksu.edu>
Date: Wed, 6 Jan 1999 15:03:59 +0100
To: debian-powerpc@lists.debian.org, linuxppc-user@lists.linuxppc.org,
        linuxppc-dev@lists.linuxppc.org, Kelly Campbell <camk@telecom.ksu.edu>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: MouseSystems MacoPoint Pro, 3 btn mouse
Message-Id: <19990106150359.027650@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 6, 1999, Kelly Campbell <camk@telecom.ksu.edu> wrote:

>What you need is the MacX kernel patch. I don't know who wrote it and I
>can't find it by searching on the list archives (I tried real hard too),
>so I guess I'll attach my most recent copy here. It works for my Mouse
>Systems Pro just fine with no tweaking mousemode... just had to recompile
>the kernel.
>
>It'd be nice to have stuff like this in the FAQ's on linuxppc.org, and
>also it'd be nice if someone could look at getting this into the cvs
>kernel if it doesn't cause too many problems with other mice. 

I'm putting together some patches that include out-of-the box support for
most 3 btn mice, PowerBook trackball (and backlight for G3 Series) and a
couple of other things. It's not ready yet, but I'm also including the
MacX patches via a config option (disabled by default since it hacks too
much the normal ADB behaviour and is not currently compatible with
non-MacX mice).

However, I don't have any of those mice. If someone with a MacX mouse
could send it to me for a couple of days, this would allow me to make
sure it works 100% (I would like to test some stuffs to improve the
behaviour of the patch but I cannot without a mouse).

So anyone with a MacX compatible mouse willing to send it to Paris for
some days ?


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
