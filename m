Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: mvista 2.0 cdk and login username and password
To: linuxppc-embedded@lists.linuxppc.org
Cc: support@mvista.com
Message-ID: <OF65A95CC9.1E398D60-ON85256AFB.006B09BF@raleigh.ibm.com>
From: "John F Davis" <johndavi@us.ibm.com>
Date: Mon, 5 Nov 2001 14:42:28 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello

What's the root login password for a newly installed sbs-k2, cdk 2.0,
target login?  The final paragraph of the sbs-k2
installation section (in the pdf) says to login, but doesn't specify a
password for root.

I installed the cd and when I try to login to a nfs root mounted partition,
I get a login prompt, but I can't login.
My installation doesn't   have a /..../target/etc/passwd file, which leads
me to believe I missed something during
the install.  However, I searched the CD for rpm's and none of them
owns/supplies  the /.../target/etc/passwd file.
Am I supposed to modify the inittab on the host machine so it boots single
user mode and create the /etc/password
file by hand, modify the inittab for multiuser mode and then reboot?

Also, when am I going to get a hardhat zone login id?  I am sure MVista has
a FAQ which addresses this issue.

John F. Davis
IBM


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
