Message-ID: <3C222B9A.9010209@embeddededge.com>
Date: Thu, 20 Dec 2001 13:19:06 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: Jakob Jepsen <JSJ@voxtream.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8xx INIT_TASK_SIZE
References: <20011220080622.4178010E18@denx.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:


> In schred.c? Do you mean include/linux/sched.h instead by any chance?
> Because that's the only place where INIT_TASK_SIZE is actually used.

There are assumptions in the 8xx tlb miss handler that everything above
0x80000000 is kernel space.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
