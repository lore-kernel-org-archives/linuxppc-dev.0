Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: Amit.Lubovsky@infineon.com
Message-ID: <AD2F581BD7340A4C908AF1AFB066EA3B0E4977@ntah901e.savan.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: MBX860 loading denx kernel image with EPPC-Bug
Date: Wed, 24 Dec 2003 11:36:54 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1255"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I try to load linux kernel 2.4.20 from denx (vmlinux) to MBX860 board
with the on board boot loader (EPPC-Bug) without success and get
the following:

EPPC-BUG output
---------------
Controller LUN =00? 20
Device LUN =00?
Node Control Memory Address =00FC8000?
Client IP Address =192.168.5.34?
Server IP Address =192.168.5.1?
Subnet IP Address Mask =255.255.255.0?
Broadcast IP Address =255.255.255.255?
Gateway IP Address =192.168.5.1?
Boot File Name ("NULL" for None) =vmlinux?
Argument File Name ("NULL" for None) =?
Boot File Length =00000000?
Boot File Byte Offset =00000000?
BOOTP/RARP Request Retry =02?
TFTP/ARP Request Retry =02?
Trace Character Buffer Address =00000000?
BOOTP/RARP Request Control: Always/When-Needed (A/W)=W?
BOOTP/RARP Reply Update Control: Yes/No (Y/N) =Y?

Update Non-Volatile Memory (Y/N)? y

EPPC-Bug>PL 20 00
Network Booting from: MPC860, Controller 20, Device 0
Loading: vmlinux

Client IP Address = 192.168.5.34
Server IP Address = 192.168.5.1
Gateway IP Address = 192.168.5.1
Subnet IP Address Mask = 255.255.255.0
Boot File Name = vmlinux
Argument File Name =

Bytes Received =&1338333, Bytes Loaded =&1338333
Bytes/Second =&446111, Elapsed Time =3 Second(s)

Exception: Implementation Dependent Software Emulation
SRR0 =C0000000 SRR1 =00001002 Vector-Offset =01000
IP =C0000000 MSR =00001002 CR =00000000
R0 =00000000 R1 =00FB4000 R2 =00000000 R3 =00FF4570
R4 =00000000 R5 =00000000 R6 =00000000 R7 =00000000
R8 =00000000 R9 =00000000 R10 =00000000 R11 =00000000
R12 =00000000 R13 =00000000 R14 =00000000 R15 =00000000
R16 =00000000 R17 =00000000 R18 =00000000 R19 =00000000
R20 =00000000 R21 =00000000 R22 =00000000 R23 =00000000
R24 =00000000 R25 =00000000 R26 =00000000 R27 =00000000
R28 =00000000 R29 =00000000 R30 =00000000 R31 =00000000
SPR1 =00000000 SPR8 =00000000 SPR9 =00000000
C0000000 0A0A0A0A TDI $10,R10,$A0A
EPPC-Bug>
Any idea what am I doing wrong?
Thanks,
Amit.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
