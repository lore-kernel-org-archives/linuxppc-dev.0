Message-ID: <3A13E1C5.6030800@galileo.co.il>
Date: Thu, 16 Nov 2000 15:31:49 +0200
From: Rabeeh Khoury <rabeeh@galileo.co.il>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: kernel 2.4 on Galileo Evaluation board
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,


I have just started porting kernel 2.4 to Galileo Technology evaluation
board, and I'm new to PowerPC architectures (intending to start with the
7400).

I have few questions so if possible please answer even part of them :

1.. What reference is the best in the kernel's source tree that I can
see that will be a good refernece for our embedded system ?
2.. The kernel is compiled to 0xc0000000 - what should I do with this
address ? should I set a BAT for translating this address to address 0x0 ?
3.. In run time - which of the MMU features the kernel uses ? BATs ,
Page tables (ofcourse) , segements ? and how they interact together ?
4.. Did any one try SMP in kernel 2.4 in PPC platforms ? and if yes ,
please drop few words regarding it !
5.. If you have a documentation regarding the booting process in ppc
platforms (especially the kernel download and firing it up process)
please send me the link.


Thank a million,
Rabeeh


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
