Message-ID: <3E37976F.4070405@imc-berlin.de>
Date: Wed, 29 Jan 2003 09:57:19 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: xiaogeng_jin@agilent.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: how to halt m8xx?
References: <9153F74610B7D311B83900902771C871124D9396@axcs07.cos.agilent.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


xiaogeng_jin@agilent.com schrieb:
> Hi,
>
> I found that in m8xx the halt function is the same as the restart function because m8xx_halt() just calls m8xx_restart() in m8xx_setup.c. If I just want to halt the m8xx system but not to restart it automatically, what should I do? Set a few registers and wait for ever? THanks for your thoughts.

How about a

	while(1);

  ???

It worked fo me!

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
