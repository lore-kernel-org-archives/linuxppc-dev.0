From: kskim@neowave.co.kr
Date: Sun, 7 Jan 2001 11:09:14 +0900
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: ppc kernel in 2.4.0 is valid?
Message-ID: <570_28348_978833354_1@mail.neowave.co.kr>
Content-type: text/richtext
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I downloaded 2.4.0 kernel yesterday, and copied config file in ppc directory to
source root. And I modified Makefile (arch :=ppc CROSS-COMPILE := powerpc-linux-
<nl><nl>

But there was some errors. It seems some bugs...
<nl><nl>

For example, in ppc directory many functions use 'unsigned long loops_per_sec
variable which is changed into 'loops_per_jiffy'(may be different but similiar)
<nl><nl>

I wonder ppc kernel 2.4.0 is valid and needs more hacking.
<nl> I'm looking forward to your answer, Happy new year!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
