Message-ID: <3727E20F.BC03ADD2@bwhitehead.com>
Date: Wed, 28 Apr 1999 23:37:35 -0500
From: Bill Whitehead <parman@bwhitehead.com>
Reply-To: parman@bwhitehead.com
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
CC: parman@bwhitehead.com
Subject: help with bootup code
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am just learning Linux and hope to port it to a custom platform using
older I/O chipsets(W83c553 and 87307). Basically the system consists of
a 603/MPC106 with 64M sdram, PCI to ISA and IDE interface(W83c553), and
I/O controller(87307). I believe the basic system is already supportted
by Linux but support for I/O chipsets must be added. I am using LinuxPPC
4.1 while waiting for release 5.

I can load the compiled kernel into high memory and jump to head.S.

I have traced the boot code(arch/ppc/boot) and think I understand the
relocate, vga_init, and decompress code but am unable to determine where
the input is coming from when fill_inbuf() is called. It gets input from
an array(input_data[]?) but I can't find where the data is assigned to
that array. I don't see an open call, a pointer assignment, or a memcpy
to draw data from. The kernel isn't running yet so Linux device drivers
aren't supplying the data.

The code is something like "if ( data_ptr < buffer_size) {
data_inbuf[data_ptr] = input_data[offset]; data_ptr++;}". I am sorry but
I don't have the code accessible at the moment. If this is too confusing
to answer, I will re-submit it tomorrow evening when the source code
listings will be available. I check the list in the evening and am
trying to get feedback as soon as possible.

I have been monitoring this list for a few weeks and have not seen these
chips mentioned except once when someone, from Korea(?), indicated they
were interested in porting Linux to a Motorola YellowKnife system which
uses them. (if your that person let me know how its going!)

Thanks in advance for you help,

Bill Whitehead
parman@bwhitehead.com


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
