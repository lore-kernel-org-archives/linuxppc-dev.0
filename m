Message-Id: <200012041243.GAA30852@localhost.localdomain>
Date: Mon, 4 Dec 2000 06:43:46 -0600 (CST)
From: jpgarcia@execpc.com, UNEXPECTED_DATA_AFTER_ADDRESS@.SYNTAX-ERROR
Subject: Re: No Backlight Control in 2.2.18pre21
To: Simon Stapleton <simon@tufty.co.uk>
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <975932158.3a2b8afe69611@rascal.ums.easynet.net>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  4 Dec, Simon Stapleton wrote:
> Thoughts, comments, flames?

http://www.execpc.com/~jpgarcia/sys.html

at the above URL, i have some links to kernel patches.  One is a patch
to implement new input layer support for the volume/mute buttons using
 a similar method to the backlight controls. The 2.4 version I wrote is
 incomplete, and the 2.2 version uses the 2.4 dmasound backport.  An
 older one is more of an update from a patch that was posted to this
 list months ago.

The new layer one also tries to feature NIL volume keys (they're in the
header), but I don't think I did it right.

Beware, I consider these patches to be 'my personal stash', and are
rather messy in places.

If anyone wants me to work on them more, or work on them themselves,
just say so.

My standing is, the buttons are there, lets use them.  iBooks and
Pismos still have them built into the keyboard too.  Do we want these
controlled kernel level, or send a keystroke so X (or something else)
can catch it?  If I can get to fixing the newer 2.2 patch, it could do
either way.

--
Joseph P. Garcia
http://www.execpc.com/~jpgarcia


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
