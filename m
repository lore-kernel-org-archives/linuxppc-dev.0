Message-ID: <404760A1.5000702@embeddededge.com>
Date: Thu, 04 Mar 2004 12:00:17 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: uncached user space mapping with mmap() ???
References: <40473464.8010203@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven Scholz wrote:

> How could I do this on an MPC8xx?

Open /dev/mem and just map the physical address of your
registers.  You don't even need your own driver.  If you
are mapping outside of the range of real memory, the mem
driver will automatically give you uncached access.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
