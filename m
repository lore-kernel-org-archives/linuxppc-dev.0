Message-ID: <4024D902.3090407@g-house.de>
Date: Sat, 07 Feb 2004 13:24:34 +0100
From: Christian Kujau <evil@g-house.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: still strange warnings when compiling 2.4.24-ben1
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



hi,

after the issue resolved that when compiling /drivers/char/defkeymap.c
produced an error (console-tools were to blame apparently)
(http://lists.linuxppc.org/linuxppc-dev/200401/msg00393.html)
hundreds of *warnings* are still left:

defkeymap.c:26: warning: excess elements in array initializer
defkeymap.c:26: warning: (near initialization for `plain_map')
defkeymap.c:26: warning: excess elements in array initializer
defkeymap.c:26: warning: (near initialization for `plain_map')
[...]

full make.log, .config and info is on
http://nerdbynature.de/bits/sheep/2.4.24-benh/2/

as you can see there are other warnings too, being less odd.
whole compiling produces 1555 warnings with the defkeymap.c issue, 19
warnings without.

console-tools is now version 0.2.3, debian/unstable version 0.2.3dbs-47.

just to let you know. 2.4.24-ben1 is running fine and finally my
scsi-realated problems are gone, being able to use the symbios2 driver
now, thanks!


Christian.
- --
BOFH excuse #444:

overflow error in /dev/null

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
