Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Message-ID: <3E563EA4.7070207@devcom.cz>
Date: Fri, 21 Feb 2003 15:58:44 +0100
From: Jan Damborsky <jan.damborsky@devcom.cz>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: connecting IDE directly to MPC8xx
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello guys,

I am using PPCBoot on my board with MPC823E.
I am lucky and I ported Linux on this board. All
works well but I don't know, how to configure
kernel 2_4_3 form ElinOS v2.0 to work with IDE hard disk connected
directly to MPC823 bus (utilizing PCMCIA bus signals
in way PPCBoot does it - in PPCBoot my IDE disk works well).

In kernel 2_4_3 from ElinOS v2.0 I use this options:
CONFIG_BLK_DEV_MPC8xx_IDE=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTIMODE=y
CONFIG_PARTITION_ADVANCED=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BLK_DEV_IDE_MODES=y
But It doesn't work at all. It crashes in do_probe() function,
when accessing bad memory region. I have mapped all
PCMCIA regions correctly.
Is any straightforward way to configure kernel to work with
this IDE connection ?
                                              Thanks in advance, HANYS


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
