Message-ID: <3D5BF80A.8296F80@esteem.com>
Date: Thu, 15 Aug 2002 11:50:50 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC8xx Low Power Mode question
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,


	I have a few questions on Low Power Modes on the MPC850/860/8xx.
My User Manual states the to switch to Normal Low Mode (the one that just
reduces core clock speed) the folowing must be true.

1.  The MSR register's POW bit must be set.
2.  The PLPRCR register's CSRC bit must be set.
3.  The PLPRCR register's TMIST bit must be cleared.

My User Manual states that when the SCCR register's PRQEN bit is set
that when an interrupt occurs that the process or will return to Normal
High Mode ( regualr fast core clock speed ).

	My first question is this, which of the 3 bits listed above
changes to accomplish this? The User Manual does not state this.

	The first person who answers this question correctly wins a case
of imaginary beer to drink with their imaginary friends.

Thanks

	Conn
--

*****************************************************************
  If you live at home long enough, your parents will move out.
 (Warning they may try to sell their house out from under you.)
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
