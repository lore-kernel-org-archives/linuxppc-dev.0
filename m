Message-ID: <3932F626.8EA4F283@embeddededge.com>
Date: Mon, 29 May 2000 18:58:46 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: The va_to_* functions
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Does anyone use these?  I need to use va_to_pte and va_to_phys on the
8xx and 8260 kernels, I couldn't find them anywhere and I believe wrote
my own functions in arch/ppc/mm/fault.c long ago.

Anyway, with the VM changes late in 2.3.xx (and now 2.4), these won't
work properly.  I need to change the first parameter in va_to_pte
from a task_struct pointer to a mm_struct pointer.  Anyone care?
Holler at me if you do.  Thanks.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
