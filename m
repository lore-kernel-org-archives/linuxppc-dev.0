Message-ID: <3CBC9E93.F2F38B42@xilinx.com>
Date: Tue, 16 Apr 2002 14:58:43 -0700
From: "Peter Ryser" <Peter.Ryser@xilinx.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Virtex II Pro/405GP
References: <1018722334.3710.3.camel@skoll.omnigon.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Bob,


> 1) What sort of boot-loader did you use?

So far we did not use a boot-loader. We boot the system in one of the following
ways:
- for development by using an external debugger. In our case this is GDB. We
know that other external debuggers that support the PPC405 work, too (see
below).
- for production
    - we include a minimal boot stub in the FPGA bitstream. This initial boot
stub then boots the rest of the system
    - we load the program into flash
    - we use System ACE. System ACE is a companion chip that reads both
bitstream and program from a CompactFlash or MicroDrive, configures the FPGA,
loads the program into memory and boots the system. System ACE acts then as an
interface to the file system on the CompactFlash/MicroDrive.
    - we are working on PPCBoot


> 2) Will the GDB debugger work with the Multilinx cable or 3rd party
> emulators like the Abatron BDI-2000.

GDB currently works with the Parallel-3 and Parallel-4 cable. Multilinx is not
supported and will never be (performance). Additional external debuggers may be
added as backends for GDB.

3rd party debuggers that we know to be working are (not an exclusive list)
- VisionProbe-II from Wind River
- VisionICE from Wind River
- Abatron BDI-2000



> 3) Is Xilinx going to make the work of porting Linux to the platform
> available to the general community?

Yes.

>  Maybe you could put the source on
> your web site or sell a Linux version of the developer's kit.

Watch out for announcements.

> 4) Will Xilinx be making a reference platform or evaluation board
> available?

Yes, this work is in progress but is not yet publicly announced. You can expect
an evaluation board to be available in Q3.

> As you can see I am eager to get as much info as possible on this.  I
> have a project that I am currently working on that this would be perfect
> for.  Any info you can point me to would be helpfull.

We are willing to give as much info as we can. But, since some of this has not
been announced yet I cannot go into all the details. Please also consider
getting into contact with your closest Xilinx representative or FAE to get more
information and to tell them about your projects.

- Peter


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
