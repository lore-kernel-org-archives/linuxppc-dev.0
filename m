Date: Thu, 5 Aug 1999 20:40:41 +0200
To: linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org,
        linuxppc-user@lists.linuxppc.org
CC: dburcaw@terraplex.com, jhaas@madison-web.com
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: BootX 1.1.2 in a tarball
Message-Id: <19990805204041.006632@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ok, I finally followed Brad Midgley suggestion to make a tarball of the
BootX folder copied to a netatalk volume. So you have a tarball
containing all the .AppleDouble stuffs. You can get this back intact on
MacOS (with resource forks, type/creators, ...) only by mounting it over
the network via netatalk. However, you win the ability to read the source
from Linux ;-) (You may still have trouble with MacOS-like carriage
returns, I'll try to fix this for the next minor release).

So welcome http://calvaweb.calvacom.fr/bh40/BootX_1.1.2.tgz ;-)

However, take care of the fact that ordinary MacOS tools like Stuffit are
completely unable to expand those things. The result is usually
unuseable. I hope someone with a bit of MacOS knowledge will find the
time to write a decompression tool for that. I do have the knowledge but
unfortunately not the time :-(

n.b. you may have noticed the cross-postingm, don't reply to all
recipients of this email !

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
