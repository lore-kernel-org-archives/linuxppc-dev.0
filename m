Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <1079.206.104.177.96.1018904994.squirrel@nevil.org>
Date: Mon, 15 Apr 2002 16:09:54 -0500 (CDT)
Subject: SMC Console not responding
From: "Daris A Nevil" <dnevil@snmc.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Reply-To: dnevil@snmc.com
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello All,

I just finished porting Linux 2.4.18 to a custom MPC860-based board.
Everything works fine except input to the console.

I have setup the console on the SMC1 port.  I use PPCBoot as the
bootloader. PPCBoot works fine for both console input and output on SMC1.
I can see the kernel boot messages, and I can even see the prompt from SASH
(but not BASH).  However, any typed characters (input) are not seen by the
console.

Is there a known problem with the 8xx_io/uart.c file in 2.4.18, or has
something changed in linux/init/main.c?

Just to answer the obvious, I have performed the following:

1. Compiled with CONFIG_CONS_SMC1 and CONFIG_SERIAL_CONSOLE
2. mknod /dev/ttyS0 c 4 64
3. cd /dev, ln -sfn ttyS0 console
4. The linux/init/main.c file seems to open the device "/dev/console" just
fine.  It also finds the initial application (either SASH or BASH).


Thanks,
Daris Nevil
SNMC

--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
