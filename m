Message-ID: <20040211214947.87373.qmail@web21110.mail.yahoo.com>
Date: Wed, 11 Feb 2004 13:49:47 -0800 (PST)
From: Lou Rickard <lou_rickard@yahoo.com>
Subject: ml300 boot loader question
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm having a hard time figuring out how to boot our
kernel/filesystem on the ml300.  I suspect it's a
problem with the bootloader, but not 100% sure.

We're able to generate a file to program the FPGA with
that will allow us to use the BDI2000 to boot the
system.  From trial and error, I've gotten the
impression that the FPGA file includes a bootloader of
some kind: when we didn't include some of the binary
firmware with the FPGA file we couldn't even get the
BDI2000 to boot the system.  When we started including
the binary firmware stuff (which I don't quite
understand yet), the system came up to a state where
we could boot with the BDI2000.

So, based on that, I'm guessing that the systemace
chip fills the bram with some sort of bootloader
sometime around when it programs the FPGA.

However, I haven't been able to build a FPGA file that
would actually boot to a linux filesystem on the flash
card.  The FPGA programs, but then nothing happens
(this is with the BDI2000 unplugged, I don't think any
software can be run with the BDI2000 plugged in unless
it's downloaded via the BDI2000, but I could very well
be incorrect).

I've looked at the Monta Vista partitions that came
with the kit.  I don't see any kind of stand alone
boot loader, so I'm guessing that they have included
their bootloader with the FPGA file.  I don't know if
this is a modification of the bootloading binaries
that come with the Xilinx development kit.

Could anyone clue me in?

Thanks,

~lr


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
