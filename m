To: linuxppc-embedded@lists.linuxppc.org
Subject: Anonymous CVS access to DENX Linux sources
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Date: Sun, 16 Jun 2002 01:37:51 +0200
Message-Id: <20020615233756.56F47102FB@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


For some time people asked me for change logs or development versions
of our Linux sources. DENX now provides anonymous CVS access  to  our
complete Linux 2.4.x kernel source tree for PowerPC.

Please use the following commands to check out a copy of our Linux
sources:

    cvs -d :pserver:anonymous@www.denx.de:/cvsroot login
    cvs -z6 -d :pserver:anonymous@www.denx.de:/cvsroot co -P linux-2.4

When prompted for the "CVS password:" just press the return key
(empty password).

Hope this helps,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
grep me no patterns and I'll tell you no lines.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
