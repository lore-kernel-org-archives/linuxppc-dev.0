Message-ID: <396DE8B7.AD4CD03D@embeddededge.com>
Date: Thu, 13 Jul 2000 12:05:11 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: zzh <david-1z@263.net>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Local sdram in 8260 board
References: <396D8712.26614@mta5>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


zzh wrote:

> ...it will get machine check exception
> at address 0x1000004 which is in the local sdram.When i disable the
> cache ,it will work.


It sounds like something is wrong with your memory controller
configuration.  The cache enable/disable also affect the type of
bus cycles that are used to access memory.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
