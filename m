Message-ID: <401D9405.5050606@iti.fi>
Date: Mon, 02 Feb 2004 02:04:21 +0200
From: Kate Alhola <kate@iti.fi>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: New platform/icecobe.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I just noticed that after cvs sync the tree does no longer compile with
framebuffer CONFIG_VT enabled and complains few undefined
symbols. I added following lines to arch/ppc/platform/icecobe.c

#ifdef CONFIG_VT
extern void mpc5xxx_setkeycode();
extern void mpc5xxx_getkeycode();
extern void mpc5xxx_translate();
extern void mpc5xxx_unexpected_up();
extern void mpc5xxx_kbd_init_hw();
#endif


Kate


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
