Date: Wed, 23 Jul 2003 21:53:28 +0000
From: Giuliano Pochini <pochini@shiny.it>
To: linuxppc-dev@lists.linuxppc.org
Subject: L1 Data Cache error
Message-Id: <20030723215328.13f99f79.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


What's this ?  L1 Data Cache error ?!?


Machine check in kernel mode.
Caused by (from SRR1=20009030): L1 Data Cache error
Oops: machine check, sig: 7
NIP: C01495DC XER: 20000000 LR: C014ACF8 SP: DA773E00 REGS: da773d50 TRAP: 0200    Not tainted
MSR: 20009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = da772000[1263] 'opera' Last syscall: 3
last math 00000000 last altivec 00000000 CPU: 0
GPR00: D9D06624 DA773E00 DA772000 DAF888C0 DD06101C 00000008 7FFFEA24 DA773EA8
GPR08: 00000000 C01495B8 FFFFEF40 000010C0 20000088 10625A60 FFFFFFA1 00000000
GPR16: DA773E38 00000040 DA773EE8 00000020 D9D07580 00000000 DA773EA8 00000001
GPR24: 00000000 00000000 D9D07314 D9D07320 D9D072C0 DAF888C0 D9D07314 D9D065C0
Call backtrace:
00000001 C014ACF8 C01A3274 C0146AFC C0146C20 C0047324 C000607C
0FFD6598 0FF0B0B0 0FF0BD3C 0FEEB97C 0FEEB2D8 0FEDC2CC 0F8EE0EC
0F953658 0F8F6EA8 10021208 1001CF3C 1001B550 0F505F70 00000000
Warning (Oops_read): Code line not seen, dumping what data is available

>>NIP; c01495dc <sock_wfree+24/84>   <=====
Trace; 00000001 Before first symbol
Trace; c014acf8 <__kfree_skb+c0/170>
Trace; c01a3274 <ip_rt_ioctl+8000/b7b8>
Trace; c0146afc <sock_recvmsg+58/a14>
Trace; c0146c20 <sock_recvmsg+17c/a14>
Trace; c0047324 <default_llseek+43c/11d4>
Trace; c000607c <set_context+270c/293c>
Trace; 0ffd6598 Before first symbol
Trace; 0ff0b0b0 Before first symbol
Trace; 0ff0bd3c Before first symbol
Trace; 0feeb97c Before first symbol
Trace; 0feeb2d8 Before first symbol
Trace; 0fedc2cc Before first symbol
Trace; 0f8ee0ec Before first symbol
Trace; 0f953658 Before first symbol
Trace; 0f8f6ea8 Before first symbol
Trace; 10021208 Before first symbol
Trace; 1001cf3c Before first symbol
Trace; 1001b550 Before first symbol
Trace; 0f505f70 Before first symbol
Trace; 00000000 Before first symbol


[Linux Jay 2.4.22-pre6 #4 SMP sab lug 19 08:29:11 UTC 2003 ppc unknown]


--
Bye.
   Giuliano.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
