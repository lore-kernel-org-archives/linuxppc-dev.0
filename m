Message-ID: <20000627095430.17482.qmail@web2105.mail.yahoo.com>
Date: Tue, 27 Jun 2000 02:54:30 -0700 (PDT)
From: Wentao Xu <xuwentao@yahoo.com>
Subject: why open("dev/console",O_RDWR,0) get stuck
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have the code from Monta Vista on my prietary board,
I find
it get stuck in the open("dev/console",..) in fucntion
init()
in init/main.c, just before to start the shell from
ramdisk.
So I put a printk("ppc405_uic_enable\n") in function
ppc405_uic_enable()
and a printk("ppc405_uic_disable_and_ack\n") in
function ppc405_uic_disable_and_ack().
both functions are in file
arch\ppc\kernel\ppc4xx_pic.c.

At last I found a output of infinite train of
ppc405_uic_enable
ppc405_uic_disable_and_ack
ppc405_uic_enable
ppc405_uic_disable_and_ack
ppc405_uic_enable
ppc405_uic_disable_and_ack
ppc405_uic_enable
ppc405_uic_disable_and_ack
........,

I get lost. Which friends can give me an idea?

Wentao


Get Yahoo! Mail - Free email you can access from anywhere!
http://mail.yahoo.com/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
