Date: Sun, 10 Oct 1999 14:31:26 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: David Riley <happyoscar42@usa.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: fb use
In-Reply-To: <3800BDB6.D53BAA73@usa.net>
Message-ID: <Pine.LNX.3.96LJ1.1b7.991010142309.16362B-100000@ofey.inetnebr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 10 Oct 1999, David Riley wrote:

> How do I get a program to access the fb?  I #included <linux/fb.h>, and
> I can use all the various structs, but none of the functions (e.g.
> fb_open) work (it fails in the linking, giving an undefined reference). 

They are not userland functions, and, thus, they can't be called.  Are
they not inside "#ifdef __KERNEL__"?

> Any help?

Take a look at any number of fb based userland programs such as fbtv and
fbi.  Their sources are available at xawtv's home page:
	http://www.in-berlin.de/User/kraxel/xawtv.html


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
