From: Ruedi.Hofer@ascom.ch
Date: Mon, 02 Oct 2000 14:46:55 +0100 (CED)
Subject: Re: Re: Re: Re: Re: VxWorks bootloader & PowerQUICC II,
 Booting the kernel
To: vanbaren_gerald@si.com
Cc: linuxppc-embedded@lists.linuxppc.org, kernel@linux01.hasler.ascom.ch
Message-id: <0G1S00J60ZIBNW@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_T3Dg6DaJQo4yXWA0vldZSA)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--Boundary_(ID_T3Dg6DaJQo4yXWA0vldZSA)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Hi Jon & Gerald

Thanx for the patches. The kernel compiles now well and even the download
to the SBC8260 seems to work. It downloads 2 sections, perfect.


CPU: EST Corp. est8260 -- MPC8260 PowerQUICC II SBC
Version: 5.4
BSP version: 1.2/4
Creation date: Apr  3 2000, 20:04:55

[VxWorks Boot]: l
boot device          : motec
unit number          : 0
processor number     : 0
host name            : linux01
file name            : vxworksZImage
inet on ethernet (e) : 10.1.20.1:ffffff00
inet on backplane (b): 10.1.20.1
host inet (h)        : 10.1.20.2
gateway inet (g)     : 10.1.20.2
flags (f)            : 0x84
target name (tn)     : ppc

Attached TCP/IP interface to motec0.
Attaching network interface lo0... done.
Loading... 45688 + 463112
entry = 0x400000
[VxWorks Boot]:
[VxWorks Boot]:
[VxWorks Boot]: g 400000
Starting at 0x400000...

<I expect the output of the kernel on SMC1.>


Questions:
1. Is my assumption right that I have to jump to address 0x400000 in order to start the kernel?
2. Dan mentioned that I have to start our stuff at 0x900000! How does this correspond?
3. I'm still using HHL1.2. Does this kernel work on my board? (It's the revision test2)
4. Does the kernel use SMC1 for the printk? I think yes!
5. Does the objdump look right?

/opt/hardhat/devkit/ppc/82xx/bin/ppc_82xx-objdump -h zvmlinux

zvmlinux:     file format elf32-powerpc

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         000041f4  00400000  00400000  00010000  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .rodata       00000470  00404200  00404200  00014200  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  2 .data         0000030c  00405000  00405000  00015000  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  3 .data.init    00000000  00406000  00406000  0008c380  2**0
                  CONTENTS
  4 .bss          00005278  00406000  00406000  00016000  2**2
                  ALLOC
  5 .gzimage      00071108  0040b278  0040b278  0001b278  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA


Thank you

\Ruedi


--Boundary_(ID_T3Dg6DaJQo4yXWA0vldZSA)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
