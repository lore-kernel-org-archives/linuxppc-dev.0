Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3E654405.6020904@ecubics.com>
Date: Tue, 04 Mar 2003 17:25:41 -0700
From: emanuel stiebler <emu@ecubics.com>
MIME-Version: 1.0
To: linux-emb <linuxppc-embedded@lists.linuxppc.org>
Subject: kernel boot on mpc8245
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I have a board which is close to Sandpoints mpc8245 cpu board.
(using internal DUARTs, EPIC_MODE_SERIAL)

Trying to get it working, I got until:

Filename 'pImage'.
Load address: 0x1000000
Loading: ################################T ###################T
##############
          ###T
##############################################################
          ##T #########################
done
Bytes transferred = 801369 (c3a59 hex)
=> bootm 1000000
## Booting image at 01000000 ...
    Image Name:   Linux-2.4.20
    Created:      2003-03-04  23:57:29 UTC
    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
    Data Size:    801305 Bytes = 782 kB = 0 MB
    Load Address: 00000000
    Entry Point:  00000000
    Verifying Checksum ... OK
    Uncompressing Kernel Image ... OK
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:mapin_ram done
MMU:setio
MMU:exit
setup_arch: enter
setup_arch: bootmem
mpc10x:enter
mpc10x:exit
arch: exit
openpic: enter
openpic: timer
openpic: external
openpic: spurious
openpic: exit


then it stops. Any idea what it is waiting for ?

And another question, I don't see any of the "printk ()" outputs I put
in the code, did I missed a flag ?

Cheers & thanks for any help


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
