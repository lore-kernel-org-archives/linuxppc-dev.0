Message-ID: <3BEA8A5D.50A75CE7@midrivers.com>
Date: Thu, 08 Nov 2001 06:36:29 -0700
From: Mark Pilon <mpilon@midrivers.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: 405 -- a little console help, part 2
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've got a little more info -- /bin/sash doesn't produce any
output and just sits there, echoing charachters typed.  I'll try poking
around w/ gdb/abatron but am not sure how to find the exec'd shell.

if I spawn ash w/ init=/bin/ash:
...
Looking up port of RPC 100003/2 on 192.168.200.4
Looking up port of RPC 100005/1 on 192.168.200.4
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 56k init
executing init = /bin/ash
sh: can't access tty; job control turned off
#

--  but at least I get a prompt and it seems to work.

I'm not sure what the message "can't access tty; job control turned off"
means -- I'll have to get the source for ash and debug it.

I would have thought that spawning init=/bin/sash would have been the
easiest.

the target filesystem is pieces of mvista's hhl2.0 target
for ppc405.

Since I'm nfs mounting it, I'm going to just mount the whole
thing and see if what I need turns up;  it'd be nice to know
for those wanting to run a more spare system.

Mark
--
Mark Pilon

Minolta-QMS
P.O. Box 37
Fallon, MT.  59326-0037

1-406-853-0433

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
