Message-ID: <40898231.20002@mvista.com>
Date: Fri, 23 Apr 2004 13:53:05 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Cc: benh@kernel.crashing.org, paulus@samba.org
Subject: Guidance Request Regarding openpic_hookup_cascade()
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings,
  In updating some of the boards for 2.6, I've encountered one without
an 8259. I can either stub-out the call to i8359_irq() in my
board-specific code or pull the openpic_hookup_cascade() support forward
from 2.4. I've been told that the cascade approach is no longer in
favor, but I have not been able to locate an alternative. So, does
anyone have a recommendation on how to proceed?

		Thanks,
		Randy Vinson
		MontaVista Software.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
