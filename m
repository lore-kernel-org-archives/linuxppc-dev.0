Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20040202213949.30276.qmail@web40408.mail.yahoo.com>
Date: Mon, 2 Feb 2004 13:39:49 -0800 (PST)
From: Todd <to_dd@yahoo.com>
Subject: ppcboot boot-up question
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm using PPCBoot 2.0.0
I have my PPC 750 setup to delay for 5sec then boot
from the DiskOnChip.  This works properly, as long as
I have an active serial connection to the board.
However, I've noticed that if there is not an active
serial connection to the board, the autoboot function
will not work.  If I reset the board, with no serial
connection, then start minicom after 10 seconds I
always find the following:

=> AT S7=45 S0=0 L1 V1 X4 &c1 E1 Q0
syntax error
=>

Does anyone know what I am doing wrong??

These are my environmental variables:

baudrate=9600
preboot=
clocks_in_mhz=1
hostname=spyder
ethaddr=00:c0:e5:10:0:99
serverip=10.1.1.107
gatewayip=10.1.1.1
ipaddr=10.1.1.28
netmask=255.255.255.0
nfs_bootfile=gesppc2
doc_bootfile=no_nfs_pImage
bootdelay=5
rootpath=/opt/timesys/linux/4.0/gesppc2/rfs
bootcmd=docboot 6000000 0
bootargs=root=/dev/nftla1 rw
ip=10.1.1.28::10.1.1.1:255.255.255.0:spyder:eth0:off
autostart=yes
autoload=yes
stdin=serial
stdout=serial
stderr=serial

Environment size: 438/4092 bytes


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
