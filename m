MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Catching bus errors in kernel mode
Date: Fri, 4 Apr 2003 09:55:14 +0200
Message-ID: <30C145E544071F4FB8B627789F7910BD32BDD9@csy-exchange1.giat.intra>
From: "ARIBAUD Albert" <A.ARIBAUD@giat-industries.fr>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm using DENX ELDK 2.0 on a mpc855t based custom board, and I am currently writing a loadable kernel module that drives a custom FPGA.

The FPGA might optionally not be there in production, but the module must be loaded anyway, and therefore must check for the presence of the FPGA.

There is no dedicated signal provided (and will not be), so the only option is reading from the FPGA's address and catching a possible bus error.

What would be the cleanest way to achieve this?

Thanks in advance,

Albert.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
