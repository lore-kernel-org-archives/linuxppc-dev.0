Message-ID: <17B78BDF120BD411B70100500422FC63079F5F@IIS000>
From: Patrick Lerda <Lerda@microprocess.com>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>,
        "'linux-kernel@vger.rutgers.edu'"
	 <linux-kernel@vger.rutgers.edu>
Subject: Linux 2.3.99-pre5 fail on PowerPC 823, and work on PowerPC 740
Date: Tue, 25 Apr 2000 17:17:53 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Linux seems to boot on PPC823, but no executable seems to be executed
properly, the partition is properly
mounted and nothing. I can ping the board, linux don't crash but execute
nothing. Probably a bug already in
the 2.3 tree for some times. I've tested Linux 2.3.99-pre5 with
the same configuration on a PowerPC 740, here all is ok, the board boot
properly after patching the NFS code.

A bug specific to the PPC823 (PPC860 ?) seems to be present here. If you
have an idea how to fix it.


Patrick LERDA

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
