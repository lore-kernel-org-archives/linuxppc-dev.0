Message-ID: <3CB6EACC.AE7BD215@lvl7.com>
Date: Fri, 12 Apr 2002 10:10:20 -0400
From: Neil Horman <nhorman@lvl7.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: problem with __init and __initdata modifiers in 2.4.19pre6
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hey all!
	I just downloaded the 2.4.19pre6 kernel from bitkeeper and I'm having some
build issues.  My compilation fails on line 35 of do_mounts.c.  I've done some
tinkering and I can only seem to resolve the problem if I remove the __initdata
attribute from the mount_initrd variable.  If I do this I clear up that error,
but I bomb out again on the next symbol to be flagged as either __init or
__initdata.  Has anyone had a simmilar experience with this kernel, and If so,
what did you do to fix it, as I'm kinda stumped here.  If it matters I'm using
gcc 2.95.3.  Thanks a bunch!
Neil :)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
