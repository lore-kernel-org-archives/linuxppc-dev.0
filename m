Message-ID: <975938608.3a2ba43030914@rascal.ums.easynet.net>
Date: Mon, 04 Dec 2000 14:03:28 +0000
To: jpgarcia@execpc.com
From: "Simon Stapleton" <simon@tufty.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: No Backlight Control in 2.2.18pre21
References: <200012041243.GAA30852@localhost.localdomain>
In-Reply-To: <200012041243.GAA30852@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Quoting jpgarcia@execpc.com,UNEXPECTED_DATA_AFTER_ADDRESS@.SYNTAX-ERROR:

> http://www.execpc.com/~jpgarcia/sys.html
>
> at the above URL, i have some links to kernel patches.  One is a
> patch to implement new input layer support for the volume/mute
> buttons using a similar method to the backlight controls. The
> 2.4 version I wrote is incomplete, and the 2.2 version uses the
> 2.4 dmasound backport.
> An older one is more of an update from a patch that was posted
> to this list months ago.

Rock! I'll give this a go tonight.  I think it's probably worth
trying to get this cleaned up and approved for a 'official' release.

> The new layer one also tries to feature NIL volume keys (they're
> in the header), but I don't think I did it right.
>
> Beware, I consider these patches to be 'my personal stash', and
> are rather messy in places.
>
> If anyone wants me to work on them more, or work on them
> themselves, just say so.

If you need any hands to the pumps, or someone to look over changes,
let me know.  Unfortunately our machines appear to be very similar,
but, as I said, I have access to a 3400.  I should also be able to
get to a firewire pbook 500 in a week or so.

> My standing is, the buttons are there, lets use them.  iBooks and
> Pismos still have them built into the keyboard too.

Aye to that.

> Do we want these controlled kernel level, or send a keystroke so
> X (or something else) can catch it?  If I can get to fixing the
> newer 2.2 patch, it could do either way.

My vote is for kernel level.  Having a volume control daemon or the
like seems very kludgy, IMHO.

A thought occurs to me, though.  A friend of mine recently bought
an I86 laptop wich has a bunch of 'shopping' buttons built in.  Are
these supported in Linux, and if so, what's the mechanism used?

Simon

--
Your mouse has moved.  You must reboot Windows NT for these changes to be
recognised.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
