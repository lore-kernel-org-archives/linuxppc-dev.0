Date: Mon, 25 Nov 2002 20:11:08 -0600 (CST)
From: "Milton D. Miller II" <miltonm@realtime.net>
Message-Id: <200211260211.gAQ2B8b05324@sullivan.realtime.net>
To: linuxppc-embedded@lists.linuxppc.org, mpilon@midrivers.com
Subject: Re:  "Extra cflags for kbuild 2.4." [ _devel tree ] 
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You didn't say which compiler you were using.  This code was added to
prevent user space headers from being included.  The -iwithprefix include
was supposed to cause gcc to add its compiler include path to the headers.
I think i read on lkml that one version of the compiler didn't do the
right think and there is an alternative command (probably posted by
Keith Owens) -- make sure you get the one that sets LANG.

milton

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
