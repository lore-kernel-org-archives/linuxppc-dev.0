Message-ID: <D73A25AA6E54D511AD74009027B1110F2C864F@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>,
	"'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: Cisco Aironet 340
Date: Mon, 30 Sep 2002 09:30:45 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,
I am trying to get a CISCO AIRONET 340 to run on an Embedded Planet CLLF
BW31.  I have the latest card service running and I have been able to get an
ATA FLASHDISK working but when I plug in the CISCO AIRONET 340 I get an
oops.  When you see "Machine check in kernel mode." is when I physically
plugged the card into the socket.  Has anybody had problem or been able to
get a CISCO AIRONET 340 working.  The kernel version I am using is 2.4.7 and
the card service version is 3.2.1.

Any help is always appreciated.
Steve

bash-2.05# insmod airo.o
bash-2.05# insmod airo_cs.o
bash-2.05# lsmod
Module                  Size  Used by
airo_cs                 4576   0  (unused)
airo                   45844   0  [airo_cs]
ds                      9568   1  [airo_cs]
m8xx_pcmcia             6180   1
pcmcia_core            40592   0  [airo_cs ds m8xx_pcmcia]
bash-2.05# Machine check in kernel mode.
Caused by (from SRR1=9032): Unknown values in msr
Oops: machine check, sig: 7
NIP: C2081238 XER: 00000000 LR: C2081214 SP: C0A21990 REGS: c0a218e0 TRAP:
0200
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0a20000[101] 'cardmgr' Last syscall: 54
last math 00000000 last altivec 00000000
GPR00: C20A4000 C0A21990 C0A20000 C20A3000 00001032 C20A3000 00000002
C037D000
GPR08: FFFFE000 C20A3000 C0A20000 00001000 00000000 10021FC4 00000000
00000000
GPR16: 00000000 00000000 00000000 00000000 00009032 00A21F40 00000000
C0002BC0
GPR24: FFFFFFE7 C0A219FA 00000002 C039C8D8 C0A219FA 00000002 C039C800
00000000
Call backtrace:
C2081214 C20818F0 C2081DD8 C2081B94 C20834CC C20904C8 C007BA74
C0002984 7C0802A6

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
