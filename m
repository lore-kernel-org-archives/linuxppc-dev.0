Message-Id: <200309300155.UAA03360@lists.linuxppc.org>
From: "Yuxiao Xi" <xiyuxiao@harbournetworks.com>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: UART prints very slow
Mime-Version: 1.0
Content-Type: text/plain
Date: Tue, 30 Sep 2003 10:07:23 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,all,
    I am developing my board with CPU MPC8240 and a UART ST16C2552.
I use MontaVista Linux 2.1. Now I have successfully logged in the
shell.But there is a question that I can't resolve:( I am sure that the
UART is successfully initialized except that ST16C2552 is detected as
ST16650.I debugged the UART interrupt and the printk info showed that it
was OK.

QUESTION: when I input commands such as 'ls', 'cd /dev' on the shell,
the characters of these commands are printed very slow on the screen
and the command execution results as well. I think these commands and
their execution results are printed through UART interrupt.Is MPC8240
interrupt ACK so slow? BTW: while system booting,the UART prints very
quickly in polling print mode.

　　　　　　　　Yuxiao Xi
　　　　　　　　xiyuxiao@harbournetworks.com
　　　　　　　　　　2003-09-30

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
