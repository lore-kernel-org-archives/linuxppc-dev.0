Message-ID: <1047784392.3e73ebc8369fa@webmail.colorado.edu>
Date: Sat, 15 Mar 2003 20:13:12 -0700
From: Phill Treddenick <Phillip.Treddenick@colorado.edu>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: problem with serial console on ep405
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am running Monta Vista Hardhat Linux 2.1 on an ep405 with solaris 2.7 as the
host.  I am able to download a zImage to the board using the Planetcore
bootloader, however when the kernel is booted I begin receiving garbage on the
host computer terminal.  I continue receiving this garbage indefinetly, which
indicates to me that the kernel is still running.  In my kernel configuration I
set the following parameters:

CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE="console=ttyS0,9600"

I have tried setting my terminal to different baud rates and changing other
settings but nothing has worked.  Here is basically what happens:

PPC4xx PlanetCore Boot Loader v1.01
Copyright 1998-2001 Embedded Planet, LLC. All rights reserved.
DRAM available size = 64 MB
wvCV
DRAM OK
>t
Load using tftp via Ethernet
Enter server IP address <128.138.189.51> :
Enter server filename   <vmlinux> : zImage_0315
Enter (B)inary or (S)record input mode <B> :
Enter address offset  : <00000000 hex> :
Enter start address   : <00000000 hex> :
Determining PHY:
 PHY at 00000 LevelOne LXT971A
.512.1024
Total bytes = 603674 in 313654 uSecs
Loaded addresses 00000000 through 00093619.
>g
[Go 00000000]

loaded at:     00000000 000951D0
relocated to:  00400000 004951D0
board data at: 00492128 00492140
relocated to:  00405608 00405620
zimage at:     00405CA0 004919EB
avail ram:     00496000 04000000

Linux/PPC load: console=ttyS0,9600
Uncompressing Linux...done.
Now booting the kernel
åÔWUÍ#ıJ
õ¨¦EEUETÑ^ÔÙß[EWUÁ
İ]K_Á[\§ñ
         eÕ
Ks\S§^uåµQE[>[¥ÅéÊÅÕUù¥EÑ²[_Q[ÅUKS&Á)ÕSå*E[e
CETEWÅy#µ[UåQç\U÷÷÷÷÷÷[íS[uTc[[Õ_¥Ü[òÅ[EÕÕÿUÁHC[Kµ¥åáRå[S
CETEWÅy#µ[UåQç\U÷÷÷÷÷÷

Am I setting the console parameter improperly or is there something else I need
to do?

Thanks,  Phill Treddenick
treddeni@colorado.edu

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
