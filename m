Message-ID: <3916D369.D89F3672@embeddededge.com>
Date: Mon, 08 May 2000 10:47:05 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Shuangjun Zhu <r44089@email.sps.mot.com>
CC: linuxppc-embedded@lists.linuxppc.org,
        damm@kieraypc01.p.y.ki.era.ericsson.se
Subject: Re: help -- PCMCIA for MPC860
References: <010301bfb8c5$ae014490$69f001dc@sjzhu.sps.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Shuangjun Zhu wrote:

> where can I get the code of PCMCIA-IDE for MPC8xx-linux-2.2.13?

Pieces of it are already in the kernel.  Scan the mailing list
archives to get Mangus' real PCMCIA patches.

In addition to this software, you will need to make (potentially lots of)
modifications to support powering the cards, unless your hardware folks
did this for you.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
