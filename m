From: bj93543@binghamton.edu
Date: Fri, 2 Mar 2001 21:54:44 -0500 (EST)
To: linuxppc-dev@lists.linuxppc.org
Subject: Q: devfs and swim3
Message-ID: <Pine.GSO.BU-L4.10.10103022135250.25059-100000@bingsun2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
Is there known any reason why swim3 floppy controler is not inserted
in devfs ?
or can be swim3.c patched like:

-swim3.c:1034:  ...register_blkdev...
+swim3.c:1034:  ...devfs_register_blkdev...

Tomas

P.S. I'm newbie in kernel hacking and not in linuxppc-dev maillist very
long so may be my question is dummy...


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
