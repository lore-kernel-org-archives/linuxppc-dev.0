Date: Thu, 7 Jan 1999 19:00:19 +0200
From: Konstantinos Margaritis <kmargar@cc.uoa.gr>
Reply-To: Konstantinos Margaritis <kmargar@cc.uoa.gr>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: debian-powerpc@lists.debian.org, linuxppc-user@lists.linuxppc.org,
        linuxppc-dev@lists.linuxppc.org, Kelly Campbell <camk@telecom.ksu.edu>
Subject: Re: MouseSystems MacoPoint Pro, 3 btn mouse
In-Reply-To: <19990106150359.027650@mail.mipsys.com>
Message-ID: <Pine.CVX.3.93.990107184738.21285A-100000@atlas.cc.uoa.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On Wed, 6 Jan 1999, Benjamin Herrenschmidt wrote:

> I'm putting together some patches that include out-of-the box support for
> most 3 btn mice, PowerBook trackball (and backlight for G3 Series) and a
> couple of other things. It's not ready yet, but I'm also including the
> MacX patches via a config option (disabled by default since it hacks too
> much the normal ADB behaviour and is not currently compatible with
> non-MacX mice).
> 
> However, I don't have any of those mice. If someone with a MacX mouse
> could send it to me for a couple of days, this would allow me to make
> sure it works 100% (I would like to test some stuffs to improve the
> behaviour of the patch but I cannot without a mouse).
> 
> So anyone with a MacX compatible mouse willing to send it to Paris for
> some days ?

Actually, after I tested the MacX patch by Kelly Campbell -although I had
to tweak it a bit, since I use 2.1.131 kernel- I found out it works
perfectly with the Macpoint Pro mouse, so instead of sending you my mouse,
I would suggest that this patch be inserted to the official kernel tree.
That would be best, IMHO.

Konstantinos Margaritis
kmargar@cc.uoa.gr



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
