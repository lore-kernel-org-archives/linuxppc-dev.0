Message-ID: <903E17B6FF22A24C96B4E28C2C0214D762F562@sr-bng-exc01.int.tsbu.net>
From: "Krishnaprasad, Raghunandan" <Raghu.Krishnaprasad@fci.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: timer_interrupt
Date: Mon, 11 Aug 2003 12:21:32 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello All,

I think this is already discussed on the list but I could not find the right
answer. I have ported "u-boot" to a MPC852T based card and I am trying to
load linux on to it. I have a 2.4.21 - pre7 kernel. I am using a BDI 2000
debugger.

It is correctly transfering controller to __start: in "head_8xx.S" and also
doing the "initial_mmu" routine. But it kind of gets after,
"turn_on_mmu" routines "rfi". And on halting the execution, it always gets
into code in "timer_interrupt" routine looks like looping around. It dosesnt
enter "early_init" etc at all.

How do I get around this problem ??

Warm Regards,
Raghu

D K Raghunandan
Force Computers Pvt Ltd.
No: 60, Kormangala Ring road
Bangalore - 560 071
Phone No: 91 + 80 + 535 6060 Ext: 324
e-mail: raghu.krishnaprasad@fci.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
