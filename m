In-Reply-To: <Pine.LNX.3.96.981231154708.14805A-100000@persephone.cs.nmt.edu>
Date: Sat, 2 Jan 1999 16:24:51 +0100
To: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: __init, __openfirmware, etc...
Message-Id: <19990102162451.002014@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all !

Could someone explain me how those directive (__init, __openfirmware,
__pmac, ...) works in the kernel ? I guess those are directive for the
linker, and I also guess that __init marked sections will be removed from
memory after kernel initialisation, but what are the other ones ? 

I ask this because I added a couple of ioctl to via-pmu (*), and as soon
as I added calls to get_user and put_user to the function, the kernel
refused to link. if I remove the __openfirmware directive from the ioctl
function, then it links fine.

(*) Cort, I have backlight control working on wallstreet, those ioctls
are for allowing user-space control of it too, I think you can remove
your stuff from via-pmu.c. I'll send you patches as soon as I have
cleaned them up a little bit, it's not urgent for 2.2.

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
