Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <81A66F72DCACD511B0600002A551BFCB4E9D5F@kuumex05.barco.com>
From: =?iso-8859-1?Q?=22Callebaut=2C_Beno=EEt=22?= <benoit.callebaut@barco.com>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: standalone boot problem with cramfs (kernel crash)
Date: Fri, 7 Mar 2003 10:46:43 +0100 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,
I have a	 working system (MPC8245 based) booted up via NFS( kernel in
flash,root filesystem on network use of ppcboot 2.0.0).
 I try to make it boot from its flash.
I enabled the cramfs, MTD(working), MTDBlock device
disabled bootp,NFS.
I changed the kernel  parameters root to /dev/mtdblock0
I use no initrd and the devfs support is enabled.

The kernel crash in the rd_load function before the rd_load_image (I think
since it is nerver executed).
What can be the problem (bad root_dev type ? )

Best regards,

----------------------------------------------------------------------------
------
Benoit Callebaut
Software Development Engineer
Barco | Control Rooms
Noordlaan 5, 8520 Kuurne, Belgium

Tel 	+32(0)56 36 84 28
Fax 	+32(0)56 36 86 05

mailto:benoit.callebaut@barco.com
http://www.barcocontrolrooms.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
