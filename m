Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "??????" <engineersong@hanmail.net>
Reply-To: "??????" <engineersong@hanmail.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: SCC3 console problem on MPC860
Date: Fri, 30 Mar 2001 09:58:39 KST
Message-Id: <20010330095839.HM.30000000001Zxx8@www4.hanmail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, all
I am not used to write in English.

I would like to use SCC3 as second console, and use SMC1 as first console.
I ported denx kernel 2.4.3-pre4 into my 860 board.
when I compiling, checked SCC3 for UART option in MPC8xx CPM option.
SMC1(ttyS0) is connected to my linux box COM2, SCC3(ttyS1) is connected to COM1.

After booting, in COM2 echo 1111 > /dev/ttyS1 result is shown in SCC3(ttyS1).
so far good.
but, COM1 port don't any receive keyboard key.

In /arch/ppc/uart.c
I modified CONFIG_SERIAL_CONSOLE_PORT for SCC3 console

#if 1
#undef CONFIG_SERIAL_CONSOLE_PORT
#define CONFIG_SERIAL_CONSOLE_PORT	1
#endif

Is it enough to to make SCC3 console?

Thanks for any comments and replyings.

==================================================
우리 인터넷, Daum
평생 쓰는 무료 E-mail 주소 한메일넷
지구촌 한글 검색서비스 Daum FIREBALL
http://www.daum.net

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
