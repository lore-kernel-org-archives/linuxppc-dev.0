Message-ID: <004f01bfd926$d25edc40$dc52df8d@oslo>
From: "SangTae Ha" <stha@postech.edu>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: How to initialize SMC2 for another console port  ?
Date: Sun, 18 Jun 2000 22:12:14 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all.

Since my team have purchased HIOX board for RPXLite, me and my friend working on HIOX SMC2 port on linux.

My question is ...

Are there any code for using HIOX SMC2 port as a secondary RS232 serial port (/dev/ttyS1) on linux?

I tried to set BCSR register, But I couldn't get the output (/dev/ttyS1).

/* uart.c */

#if 1
        /* This enables HIOX Extension Board, I think */
         *((uint *)0xfac00000) = ((uint)0x380F3C00);

#endif

We use MontaVista linux-2.2.13-7.

Thanks in advance.

Have a nice day.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
