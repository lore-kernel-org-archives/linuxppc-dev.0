Subject: DBCR0 reset?
From: Hollis Blanchard <hollis@austin.ibm.com>
To: embedded list <linuxppc-embedded@lists.linuxppc.org>
Date: 29 Oct 2002 13:18:19 -0600
Message-Id: <1035919100.1013.1226.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Has anyone had problems with hardware breakpoints from external
debuggers? I'm using RISCWatch, which sets DBCR0 and IAC1 for me (yes
I've verified that). I'm then using 'echo > /proc/sys' to invoke my
code. However by the time I get to my sysctl proc handler, DBCR0 has
been reset from 0x80810000 to 0x00010000, hence IAC1 is ignored.

I don't see much use of DBCR0, other than initialization and then save
during exception prologs and then restore during task restore. Can
anyone point me to where it might be reset?

-Hollis

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
