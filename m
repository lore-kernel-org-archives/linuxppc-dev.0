Message-ID: <3A417BB1.22F6E226@wolf-359.net>
Date: Wed, 20 Dec 2000 21:40:34 -0600
From: "William J. Mittelstadt" <mittewil@wolf-359.net>
Reply-To: mittewil@bigfoot.com
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: irda on pismo
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have been trying to get irda working on my powerbook to sync with my
palm. I have followed the settings suggested in the irda faq but still
can't seem to get it to work. I am running the 2.2.18 kernel from
kernel.org with all the irda stuff compiled as modules. The only error i
get is reported in dmesg:

irda_setup timed out on 1st byte
irda_setup timed out on 1st byte
IrDA (tm) Protocols for Linux-2.2 (Dag Brattli)
IrCOMM protocol (Dag Brattli)
IrDA: Registered device irda0
ircomm_tty_attach_cable()
ircomm_tty_ias_register()
irtty_net_open()
irlap_change_speed(), setting speed to 9600
ircomm_tty_close()
ircomm_tty_shutdown()
ircomm_tty_detach_cable()
ircomm_close()

This is the output when I run the irattach /dev/ttyS1 command. I saw
that someone posted with this issue but never saw any fix. Any help
would be appreciated.

Thanks


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
