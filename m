Message-ID: <3CB6F072.B068FC40@lvl7.com>
Date: Fri, 12 Apr 2002 10:34:26 -0400
From: Neil Horman <nhorman@lvl7.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: regarding the 2.4.19pre6 kernel
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hey again!
	Please disregard my last question regarding the compilation failure of
do_mounts.c in the 2.4.19pre6 source tree.  After looking through the change
logs, I found that a recent merge which removed the line:
#include <linux/init.h>
Was the culprit.  Sorry.
Neil :)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
