Date: Sun, 26 Mar 2000 20:10:07 +0200
Subject: Another IDE problem
From: "Florent" <flobo@iname.com>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20000326181526.9415C741D1@postfix2.free.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I rsynced last night with Paul's kernel tree (version 2.3.99), and it
successfuly compiled. But when it booted, it failed detecting my ide hard
drive :

hda: invalid geometry:255 physical heads
hda: driver not present
vfs: Cannot open root device etc...

I tried to specify the geometry manualy (hda=cyl,hds,sec) with no more
success but a new error:
hda: lost interrupt

Sorry about being a newbie in 2.3.x kernels, I saw there were many problems
in the list archive related to ide, but none seemed to match exactly mine.
I am using a B&W G3 with yaboot.

Florent

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
