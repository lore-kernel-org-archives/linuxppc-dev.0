Message-ID: <39804084.5EA8BA01@embeddededge.com>
Date: Thu, 27 Jul 2000 10:00:36 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Hyun-Joon Cha <tachyon@postech.ac.kr>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Req. help about SCC2 and SCC3 as ethernet.
References: <01ba01bff79b$9ee78db0$1952df8d@SOYANG>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hyun-Joon Cha wrote:

> After such a success, we removed SCC2 and make SCC3 default ethernet ... then Linux hangs at serial_console_write.

How do you know that is where it stops?  With SCC3, you are now
trying to configure Port B, which is also used for the SMC1 configuration.
Perhaps the console and kernel are working fine, and you just messed up
the I/O pins for SMC1.

You will also need to make source code changes to enet.c, as it doesn't
have a standard set of instructions for configuring port B as Ethernet
control/data pins.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
