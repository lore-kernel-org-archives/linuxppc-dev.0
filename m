In-Reply-To: <199908310148.LAA14647@tango.anu.edu.au>
Date: Tue, 31 Aug 1999 19:20:04 +0200
To: Paul.Mackerras@cs.anu.edu.au
CC: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: A few sleep patches
Message-Id: <19990831192004.022815@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



At:

<http://calvaweb.calvacom.fr/bh40/test.html>

You'll find a few patches to apply to your latest stable tree. I've
changed a bit of things in the media bay code (increasing reset timer and
a few more hacks to make sure the states goes to MB_NO before switching
to a new device, just in case...), it looks a lot more reliable on my
wallstreet (no more CD badly inserted printk, at least not today ;-)

I've added the sleep code for media bay, macserial (untested) and fixed a
minor thing in the sleep code for video (added a chipid, enabled FB
backup (we may be able to get rid of it, I'm not sure for LP_CHIP_ID)).

There may be one or two more things, I don't remember if I included my
root partition detect fix (actually, I don't remember if my mkpatch
script did diff drivers/block/genhd.c and can't test now).

Tell me if it causes trouble on your machine, I'll try to do more tests
tomorrow.

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
