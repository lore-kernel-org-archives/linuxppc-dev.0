Date: Thu, 6 Jan 2000 16:39:38 -0500
From: brad allison <jackal@aol.net>
To: Multiple recipients of list <linuxppc-dev@lists.linuxppc.org>,
        linuxppc-user@lists.linuxppc.org
Subject: MOL error: newworld: elf32_getehdr failed 
Message-ID: <Pine.SGI.4.00.10001061636570.18356-100000@osiris.office.aol.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



I did a search on lists.linuxppc.org for elf32_getehdr and came up with
nothing...

So like has anyone else experienced this?  Know a fix?

bash-2.03# /usr/bin/startmol
Using MOL library directory /usr/lib/mol
Mac-on-Linux 0.9.30 
(C) 1997-1999 Samuel Rydh, <samuel@ibrium.se>
Using resource file '/etc/molrc'
in_security_mode 0
MOL kernel module 1.1.30
OF Device tree copied from kernel
Loading OF device tree from 'oftrees/oftree.nw'
32MB RAM mapped at 0x20000000
newworld: elf32_getehdr failed
cleaning up...
Terminating threads...
Done
DONE

-- 
AOL SAPI    jackal@aol.net    jackal@kmfms.com    703.265.0908   AIM:jackal242 
http://jackal.fudge.org        `I was never more certain of how far away I was 
from my goal than when I was standing right beside it.' - Ethan Hawke, Gattaca


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
