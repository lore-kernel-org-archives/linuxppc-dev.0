Message-ID: <3BABA566.365ACF68@mvista.com>
Date: Fri, 21 Sep 2001 16:39:02 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: IDMA on MPC855/860 ?
References: <3BAB0FFB.4CA071CB@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven Scholz wrote:

> Can anyone point me to some driver code already in the recent linuxppc
> that are using the MPC's IDMA, please?

All of the MPC8xx unique drivers use DMA....it's the only way
to transfer data through the CPM.  Just take one of the drivers,
like uart.c or enet.c, and remove everything except the buffer
descriptor management.  Then just add the few lines of code to
initialize the IDMA channel and you are done.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
