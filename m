MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: Problems bring up NFS mount on MPC8270 board
Date: Thu, 23 Oct 2003 21:15:23 -0400
Message-ID: <8529B5552D4EAA4DAEDF49650C64B2B41673CC@tarpon.mangrovesystems.com>
From: "Joe Birch" <jbirch@mangrovesystems.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello

I am trying to bring up the kernel on custom hardware based on the
MPC8270.

I've ported the LSP from Embedded Planet EP8260. I am using u-boot 4.0

After doing NFS mount of FS, I usually get these message on the console:

INIT: version 2.78 bootimory: 56k init.
INIT: Entering runlevel:
INIT: no more processes left in this runlevel

Console locks but I can ping the board successfully

Sometimes get passed this and get:

INIT: version 2.78 bootimory: 56k init.
Activating swap...
Checking all file systems...
Parallelizing fsck version 1.22 (22-Jun-2001)
Calculating module dependencies...

And then the target stops (crashes)


I have checked SDRAM memory (U-boot post) and its OK.

Any ideas?
Thanks
Joe

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
