Message-Id: <5.1.0.14.2.20030718012800.00afeb48@mail.ebshome.net>
Date: Fri, 18 Jul 2003 01:37:59 -0700
To: linuxppc-embedded@lists.linuxppc.org
From: Eugene Surovegin <ebs@ebshome.net>
Subject: [PATCH] consistent_sync unaligned buffers debug check
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi!

These patches add new debugging option under "Kernel hacking|Kernel debugging".
This option enables rate-limited warning print out when consistent_sync is
called with unaligned buffer.

Patch against 2.4:
http://kernel.ebshome.net/consistent_sync_debug-2.4.diff

Patch against 2.6
http://kernel.ebshome.net/consistent_sync_debug-2.6.diff

Comments/suggestions :)

Eugene.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
