Message-ID: <A33AEFDC2EC0D411851900D0B73EBEF7063E87@NAPA>
From: Hua Ji <hji@netscreen.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: About TLB mapping
Date: Thu, 25 Jan 2001 16:42:41 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, folks,

Advice needed.

I am writting my TLB mapping for 405GP 128M physical memory.
When I try to assemble my codes. I got some error called:
"Unrecognized opcode: tlbwe".

I am confused and am asking for help. Thanks in advance.

Or do I missed some options for my make file? My working environment is:
*  powerpc-eabi-gcc and corresponding as....
*  I tried to use -mcpu=405 to let as know that I am expecting 405cpu:-)



#-------------
#Error Message I got from compiler and assember
#------------------------------------------
 : Error: Unrecognized opcode: `tlbwe'
 : Error: Unrecognized opcode: `tlbwe'

#-------------
#My codes sample
#-----------------------------------------------------
 li      %r0,0                 #TLB Entry 0
 tlbwe	%r4,%r0,1
 tlbwe	%r3,%r0,0
#-----------------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
