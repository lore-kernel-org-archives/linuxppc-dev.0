Message-ID: <37D0F88E70D96C428C19EEB865701A38E27342@buda902a.siemens.hu>
From: =?ISO-8859-1?Q?M=E9sz=E1ros_Lajos?= <ludwigm@siemens.hu>
To: "linuxppc-embedded@lists.linuxppc.org (Elektronikus levelek)" <linuxppc-embedded@lists.linuxppc.org>
Subject: kernel on MPC8260ADS - character losing
Date: Mon, 27 May 2002 14:19:25 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

I'm trying to run 2.4.4 on MPC8260ADS.
PpcBoot works fine. After booting the kernel image
(Uncompressing Kernel Image ... OK) there is emitting of weird
characters; losing every second one, some are doubled as follows:

TTaammoo  11BBuunn00  rraa  bb a 0000
   = ???
Lnxvrin244(oth238.UUA0A
   = Linux version 2.4.4 (username)
gcvrin303 1 h a 31:43 ET20
   = gcc version 3.0.3 (datetime)
O oe0ttlae:49
zn() 06pgs
   = ??? pages
zn()  ae.
   = ??? pages
oe2:0pgs
   = ??? pages
Kre omn ie ot/e/a w
   = Kernel ??? /dev/
ann:ra iecoksessuk
   = Warning: ???
airtn ea op.8888BBooPP
   = Calibrating delay loop
mmyy1199  aaaaee88kkeeeeccee24 aa 8 nt khgmm
nnyyaaeeaa  bb nre:24 odr ,134bts
   = ??? bytes
ffrccehs al nre:12 odr ,49 ye)
g-ah ahtbeetis 06(re:2 68 ye)
oo--cehs al nre:12 odr ,89 ye)
OOXXofrac etn yUII
   = POSIX conformance testing by UNIFIX
LLuuNN44  rriixx..
ss  ooSSnnaUiest optrScey
   = ??? Swansea University Computer Society
NT.3
   = NET3.039
SSrrnnkwp 18 MMAA  iirreein00 tS nSC t000,BG

Did anybody experience such effect with serial port?

	Ludwig

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
