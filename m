Date: Wed, 26 May 1999 15:03:56 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: Elliot Lee <sopwith@redhat.com>
cc: jpgarcia@execpc.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: endian patches to esound, audiofile, x11amp_beta for pbG3
In-Reply-To: <Pine.LNX.4.10.9905261102420.9719-100000@lacrosse.corp.redhat.com>
Message-ID: <Pine.LNX.4.05.9905261502380.26691-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 26 May 1999, Elliot Lee wrote:

> The audiofile in GNOME CVS is supposed to have a lot of endianness fixes
> already - you may want to try it. (Not sure how binary compatible it is
> with 0.1.6 though).
> 
> Anyways, my main point is that you really need to get these patches to the
> original authors of the respective packages so that they can be
> integrated. The audiofile author is michael@68k.org. The esound author is
> ericmit@ix.netcom.com (that e-mail address reportedly no longer works
> though - perhaps try getting things through raster@redhat.com instead).

The main reason most of these programs don't "work" right now is they were
fixed at one point.  The dmasound driver used to be in big endian mode.
Now, it's in LE mode and all the old patches need to be reversed on LPPC,
but not for MkL.  It can be a bit messy.  But, there is a semi-elegant fix
for it all.

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
