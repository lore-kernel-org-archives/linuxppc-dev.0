Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Tue, 1 Jul 2003 16:29:44 -0400
From: Kent Borg <kentborg@borg.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Large initrd and arch/ppc/boot/simple Question
Message-ID: <20030701162944.E20876@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We are booting our kernel via the arch/ppc/boot/simple mechanism to
package up our kernel and initrd.  It seems to work, until we get too
big.  What is big?  Roughly 8 MB for our one big uncompressed userland
program, plus the kernel, bash, busybox, and various userland
utilities.

Can initrd's get that large and still work?  Is the simple boot code
sensible with these sizes?  (I notice that the "avail ram" message
that gets printed is just hard coded number...)


Thanks,

-kb, the Kent who is running roughly 2.4.21-pre6.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
