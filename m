Message-ID: <20021014140317.93122.qmail@web13401.mail.yahoo.com>
Date: Mon, 14 Oct 2002 07:03:17 -0700 (PDT)
From: Norm Legare <normlegare@yahoo.com>
Subject: Debugging Linux kernel at "start_here"
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello All,

I am using the SELF package from Denx (Linux version 2.4.4 kernel
combined with a ramdisk).  I have modified the bd_info struct to be
the same as ppcboot's.  Also, I have the mpcbdm adaptor and am
starting it with an mpc_init file tailored for a TQM board even
though I have an MBX860 board.  After getting the board to stop at
"start_here" inside the file ./arch/ppc/kernel/head_8xx.S, the
debugger output displays this:

0xc0002190 <start_here>: I!I!I!fnmadd. f31,f31,f31,f31

I have verified that the uncompressing of the kernel image is OK
by inspecting the disassembly around address 0x2190 (physical
address for the "start_here" function).  I load the combined kernel
and initrd images (pMulti) at RAM address 0x200000 via a serial
connection and then from ppcboot do the command "bootm 200000".
The output that is displayed stops after "Transferring control to
Linux...".

Any suggestions?

TIA,
Norm


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
