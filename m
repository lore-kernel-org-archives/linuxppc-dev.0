Return-Path: <ningmin@yahoo.co.jp>
Received: from web605.mail.yahoo.co.jp (web605.mail.yahoo.co.jp [211.14.15.79])
	by ozlabs.org (Postfix) with SMTP id 2CC2367A88
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 23 Jan 2005 20:03:32 +1100 (EST)
Message-ID: <20050123085652.42295.qmail@web605.mail.yahoo.co.jp>
Date: Sun, 23 Jan 2005 17:56:51 +0900 (JST)
From: ning <ningmin@yahoo.co.jp>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Subject: Serial console problem on MPC8272ADS board 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello to all

I am trying to use ttyS1(SCC4) as Linux serial console
port on on MPC8272ADS board.
but it doesn't work. 
My linux kernel is 2.4.22,and using u-boot-1.1.1 as a
bootload.
Linux kernel doesn't output any log information after
u-boot's message:
 Uncompressing kernel Image ...  OK
 
If I use ttyS0(SCC1) as a serial console port,Linux will
startup successfully.

  CPM UART driver version 0.01
  ttyS0 at 0x8000 is a SCC
  ttyS1 at 0x8300 is a SCC
  ...

I found serial console port seems be defined in
/arch/ppc/8260_io/uart.c,
but it doesn't work enen if I change
CONFIG_SERIAL_CONSOLE_PORT to 1 (default:0) 

I wonder serial console port only can be set to
ttyS0(SCC1) on MPC8272ADS?

Thanks.

__________________________________
Do You Yahoo!?
Upgrade Your Life
http://bb.yahoo.co.jp/
