Message-Id: <200309180127.UAA09566@lists.linuxppc.org>
From: "Yuxiao Xi" <xiyuxiao@harbournetworks.com>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: question about UART ST16C2552 
Mime-Version: 1.0
Content-Type: text/plain
Date: Thu, 18 Sep 2003 9:37:45 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,all,
    Does Linux support UART ST16C2552 ?
    There is a UART ST16C2552 on my board with CPU ppc8240.
While the linux system booting,sometimes function autoconfig(struct
serial_state * state) in ./drivers/char/serial.c detected ST16C2552 as
16450,sometimes as 8250,can anyone tell me why?

　　　　　　　　Yuxiao Xi
　　　　　　　　xiyuxiao@harbournetworks.com
　　　　　　　　　　2003-09-18

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
