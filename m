Date: Wed, 26 May 1999 11:09:20 -0400 (EDT)
From: Elliot Lee <sopwith@redhat.com>
To: jpgarcia@execpc.com
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: endian patches to esound, audiofile, x11amp_beta for pbG3
In-Reply-To: <199905260525.AAA06870@pop02.execpc.com>
Message-ID: <Pine.LNX.4.10.9905261102420.9719-100000@lacrosse.corp.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 26 May 1999 jpgarcia@execpc.com wrote:

> attached are a set of patches for audiofile, esound (in PPC DR1.0),
> and x11amp-0.9_beta1.1-1 to fix the endian problems in sound.  I am
> running kernel 2.2.9 on a pbG3 300.  If you try to play mp3s and only
> get static, these should fix that.  they can be added into the .spec
> file to build an RPM no problem.  If anyone hasn't had this problem, i
> don't know why mine it acting odd.
> 
> Some of the patches are brute force, so there are better solutions out
> there.  Mostly quick late nite fixes so i can play mp3s.  But they
> work for me, so enjoy.  Any feedback would be cool.

The audiofile in GNOME CVS is supposed to have a lot of endianness fixes
already - you may want to try it. (Not sure how binary compatible it is
with 0.1.6 though).

Anyways, my main point is that you really need to get these patches to the
original authors of the respective packages so that they can be
integrated. The audiofile author is michael@68k.org. The esound author is
ericmit@ix.netcom.com (that e-mail address reportedly no longer works
though - perhaps try getting things through raster@redhat.com instead).

-- Elliot
"We're sorry, we didn't know it was supposed to be invisible."
	- Sign carried outside US embassy.



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
