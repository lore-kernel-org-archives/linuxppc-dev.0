From: Paul Mackerras <paulus@linuxcare.com>
To: Linux/PPC Developer list <linuxppc-dev@lists.linuxppc.org>
Subject: insw/outsw in ide.h
Date: Wed, 1 Mar 2000 17:22:29 +1100
Content-Type: text/plain
Cc: Cort Dougan <cort@fsmlabs.com>
MIME-Version: 1.0
Message-Id: <00030117261302.01280@argo.linuxcare.com.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Is there any PPC platform that needs to use a byte-swapping insw/outsw in
the IDE driver?  (I can't see why any platform would, but you never
know...)

I have changed the insw/outsw/insl/outsl in include/asm-ppc/io.h to be the
non-swapping form (in my tree at least, I'll push it to bk soon).  I would
like to take out the special definitions of insw/outsw in
include/asm-ppc/ide.h and just let the ide driver use the standard
(non-swapping) form.  Will this cause a problem for any PPC platforms?

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
