Date: Thu, 20 Feb 2003 09:33:07 +0100 (CET)
From: Samuel Ortiz <samuel.ortiz@smartdata.ch>
To: linuxppc-embedded@lists.linuxppc.org
Subject: PPC405 UART
Message-ID: <Pine.LNX.4.44.0302200924430.711-100000@jourdain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi guys,

I'm currently working on a IBM ppc405 core based STBx25 board, and I'm
trying to hack its UARTs.
For those of you who are not familiar with these boards, the UARTs are
"almost" standard ones. Their only difference with the typical 16550 ones
is that they use 2 divisors instead of just (DLL+DLH) to fix the baud
rate.
I'm tweaking the serial.c driver in order to use both divisors, but with
no success so far.

So my questions to you would be :

- Are some of you working on the same core/boards (i.e. IBM STBx25 set
  top boxes) ?
- If yes, have you ever tried to use the 2 available divisors on the UARTs?
- If no, then do you know of some other mailing list, IRC channel, news
  group or web site where I could find any kind of help related to my
  problem ?

Any suggestions, remarks, hints are greatly appreciated.

Thanks in advance for your help.

Cheers,
Samuel.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
