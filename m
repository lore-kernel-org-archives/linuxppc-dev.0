From: xiaogeng_jin@agilent.com
Message-ID: <9153F74610B7D311B83900902771C871124D9396@axcs07.cos.agilent.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: how to halt m8xx?
Date: Tue, 28 Jan 2003 17:00:45 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I found that in m8xx the halt function is the same as the restart function because m8xx_halt() just calls m8xx_restart() in m8xx_setup.c. If I just want to halt the m8xx system but not to restart it automatically, what should I do? Set a few registers and wait for ever? THanks for your thoughts.

Regards,

- Shawn.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
