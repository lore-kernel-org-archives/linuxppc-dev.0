Date: Thu, 4 Feb 1999 16:52:56 -0600 (CST)
From: Takashi Oe <toe@unlinfo.unl.edu>
Reply-To: Takashi Oe <toe@unlinfo.unl.edu>
To: "dhiltgen@toocool.calpoly.edu" <dhiltgen@toocool.itslab.calpoly.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: matroxfb, anybody? (More details...)
In-Reply-To: <19990203214943.A493@toocool.calpoly.edu>
Message-ID: <Pine.LNX.3.96LJ1.1b7.990204163413.6530A-100000@selq119.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Wed, 3 Feb 1999, dhiltgen@toocool.calpoly.edu wrote:

> I tried to pass the parameters to control at bootup hoping that 
> would circumvent the problem by using:
> 
> append="video=matrox:vesa:0x11a,nopan,fv:80 video=control:vmode:6,cmode:32"

I don't know about the latest vger source tree, but 2.2.1 from kernel.org
or 990201 vger source at linuxppc.cs.nmt.edu don't have the necessary
codes to support that for controlfb.  It probably makes no difference for
your problem, but you can try the patch below:

ftp://ppc.linux.or.jp/pub/users/toe/planb/patch-990128.diff.gz

This contains the patches (fbmem.c and controlfb.c) for setting boot time
options among other things.


Takashi Oe


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
