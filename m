Message-ID: <3A8C5A95.9A94F914@mvista.com>
Date: Thu, 15 Feb 2001 14:39:17 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Cc: frowand@mvista.com
Subject: program exception emulates mfspr PVR
References: <20010215160658.P26702@altus.drgw.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Why did emulate_instruction() get added into traps.c to emulate the
mfspr PVR instruction?  What user space application is using this
instruction?

And why add this extra cruft?  The information is already available to
user applications (one example, /proc/cpuinfo reports the cpu and revision).


Thanks,

Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
