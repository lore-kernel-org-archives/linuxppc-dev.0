Message-ID: <3E05AC49.7080604@tataelxsi.co.in>
Date: Sun, 22 Dec 2002 17:42:57 +0530
From: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org,
	kernelnewbies <kernelnewbies@nl.linux.org>
Subject: doubt in arch/ppc/8260_io/uart.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
in kernel 2.4.17, arch/ppc/8260/uart.c contains the following lines in
rs_8xx_stop()
{
....
sccp->scc_sccm &= ~UART_SCCM_TX;
....
}
UART_SCCM_TX is defined to 0x00000020
i.e, only the TX bit is 1

Now the manual (MPC8260UM.pdf) states that clearing a bit is 1 for both
SCCE and SCCM. Following it, what I understand is the above C statement
clears all the bits of ccp->scc_sccm except TX bit.

Then how does it stop the SCC/SCM?
Clearly something is wrong in _my_ logic, what can that be?


Thanks for your time,
Om.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
