Message-ID: <3874C8D8.835DBC64@pop.agri.ch>
Date: Thu, 06 Jan 2000 17:55:00 +0100
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: remote debugging?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I try to remote debugging a kernel.
Configuration as follows:

pm7200 Linux <------ serial cable------> PowerBook MacOS ZTerm

the physical Link is ok, when cat'ing a file to /dev/ttyS1 I get it on
the ZTerm window.

But when I boot with BootX I add the kernel args 'console=/dev/ttyS1' in
the corresponding field.

The first stage text I see on the pm7200, afterwards Tux comes up and no
booting messages are seen either on the pm7200 (what I expect) nor on
the ZTerm window. (what I don't expect).

The serial settings are as described in the xmon.txt 38400N81
The kernel is compiled with xmon included, the one I test boots and is a
2214pre18. It's only to find out how 'remote' works.

Any ideas/experiences?

Thanks in advance,

Andreas
-- 
| Andreas Tobler				
| CH-8004 Zuerich 							
| E-Mail:   a.tobler@schweiz.ch
-----------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
