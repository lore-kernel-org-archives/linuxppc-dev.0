Date: Tue, 15 Dec 1998 14:37:56 +0100
To: linuxppc-dev@lists.linuxppc.org
CC: paulus@cs.anu.edu.au
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: BootX, ramdisk and root device
Message-Id: <19981215143756.003692@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi All !

A couple of questions for which I would like feed-back before changing BootX:

I've seen users having troubles because they both checked the "Use RAM
Disk" box and wrote some incorrect infos in the /dev/xxx edit field of BootX.

I was wondering: Is there any case where a user may want to have both
"Use RamDisk" and a specified root device ? Should I ignore the content
of the root device field when ram disk is used ? (It still possible to
force it by typing the parameter manually in the kernel args anyway).

Similar issue: should I lookup and remove any "video=xxxx" option from
the kenrnel args prior to booting the kernel when "no video driver" is
checked or is this harmless ?

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
