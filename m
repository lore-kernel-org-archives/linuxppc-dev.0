Message-ID: <3ABCBFC3.14FCC0B4@denise.shiny.it>
Date: Sat, 24 Mar 2001 16:39:47 +0100
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Sound skips
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


When I play music under high load the sound has a lot of
short interruptions. It seems not to be related with I/O. I tried
Alsaplayer and xmms with OSS output. Xmms with esd is better but
not perfect. Xmms uses a buffer of 2KB but I had to patch it to
use a 8KB large one to make it play fine on my G3, but it still
jumps sometimes on the G4.
This happend on my G3 and a friend's G4(2000).
I don't remember my 7300 had this problem.

I don't know what causes that (ints kept disabled too much time ?)
but if someone has a patch to try I'me here.

Bye.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
