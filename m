Date: Sun, 14 Feb 1999 15:33:59 +0100
To: linuxppc-dev@lists.linuxppc.org, Paul Mackerras <paulus@cs.anu.edu.au>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: BootX and disk images: stop ?
Message-Id: <19990214153359.002164@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have some work in progress on BootX (1.1aX) that involves support for
building a physical "map" of a disk image to give the kernel for booting.

I'm wondering if this is still interesting and If I should just throw
this code away since supporting it via a loop-device on kernel's HFS is a
better long-term solution and since HFS+ support is beeing worked on.

Basically, the goal of this code was to provide the kernel with a map of
the physical blocs used by the image along with some infos to locate the
device.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
