Date: Sun, 25 Jun 2000 17:33:01 -0400 (EDT)
From: "Mark S. Mathews" <mark@absoval.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: PLPRCR & Checkstop reset
Message-ID: <Pine.LNX.3.96.1000625172850.17884A-100000@tristar.cc.absoval.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Folks,

We're using the mvista 2.2.13-3 kernel sources and I'd like to add a
software reboot capability.  I've figured out that I need to add an enable
of CheckstopReset and generate a MachineCheck in head.S.  Before I go
muddling through the assembly (I'm pretty clueless there), I was wondering if
someone had a snippet to share that would force the hard reset I'm looking
for.

Thanks,
-Mark

Mark S. Mathews

AbsoluteValue Systems      Web:    http://www.linux-wlan.com
P.O. Box 941149            e-mail: mark@linux-wlan.com
Maitland, FL 32794-1149    Phone:  407.644.8582
USA                        Fax:    407.539.1294


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
