Message-ID: <38DF707F.DF49A490@raleigh.ibm.com>
Date: Mon, 27 Mar 2000 09:30:23 -0500
From: Ralph Blach <rcblach@raleigh.ibm.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: 405gc problem with shared libraries
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am attempting to run the latest 405gc port and am getting error.

I boot up to sash, and then run the command ls
everthing seems to run fine untill I get the message

./ls: error in loading shared libraries: libc.so.6: failed to map
segment
 from shared object: Error 19

This message is from ld.so.1.  What is ld.so.1 trying to do?  Any
suggestions.

Chip

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
