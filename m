From: Ruedi.Hofer@ascom.ch
Date: Wed, 27 Sep 2000 16:11:48 +0100 (CED)
Subject: VxWorks bootloader & PowerQUICC II, Booting the kernel
To: linuxppc-embedded@lists.linuxppc.org
Cc: dan@mvista.com, vanbaren_gerald@si.com, kernel@linux01.hasler.ascom.ch
Message-id: <0G1J00L5RU694U@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_4BxJnlZCieyH3nEZJ3Efnw)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--Boundary_(ID_4BxJnlZCieyH3nEZJ3Efnw)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Hi,

I try to boot the Linux kernel on a SBC8260 evaluation board using
the VxWorks bootloader.

In order to be able to load the whole kernel at address 0x900000,
I had to modify the ELF header of the zImage file. I basically changed
the length and the start address.

Question:

1. Why is the length in the ELF header wrong?

2. Why is the start address set to 0x400000 and not to 0x900000?


After loading the kernel, I try to run it:

Attaching network interface lo0... done.
Loading... 493164
entry = 0x900000
[VxWorks Boot]: g 900000
Starting at 0x900000...

program
Exception current instruction address: 0x00900000
Machine Status Register: 0x00089000
Condition Register: 0x24000082
Task: 0xfd37f8 "tBoot"

r0     =   e02684   sp     =   fd3498   r2     =        0   r3     =        0
r4     =  1000000   r5     =        0   r6     =        0   r7     =        0
r8     = 40000000   r9     =   e60000   r10    =   e5f1dc   r11    =   fd3498
r12    =        0   r13    =        0   r14    =        0   r15    =        0
r16    =        0   r17    =        0   r18    =        0   r19    =        0
r20    =        0   r21    =        0   r22    =        0   r23    =        0
r24    =        0   r25    =        0   r26    =        0   r27    =        0
r28    =   e010b8   r29    =   900000   r30    =        0   r31    =   fd3498
msr    =    89000   lr     =   e02690   ctr    =        0   pc     =   900000

[VxWorks Boot]:


.. but it crashes.

Any ideas? I'm using the kernel from HHL1.2, standard config but initrd disabled!

3. What am I doing wrong?

Thank you

Ruedi


--Boundary_(ID_4BxJnlZCieyH3nEZJ3Efnw)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
