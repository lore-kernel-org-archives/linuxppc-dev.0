Date: Thu, 08 May 2003 09:53:36 -0700
From: Peter Ryser <Peter.Ryser@xilinx.com>
Subject: Re: advice please: virtex pro 2
To: James Don <JDon@spacebridge.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Message-id: <3EBA8B90.36E24A3E@xilinx.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <DB0585C9F6F9D411BE8F00D0B7896A4CC065FE@SNCMAIL>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


James,

> 1.) Is it just as "easy" as an MPC860 or MPC8260 based platform ?

Once you have a board with a bitstream for the FPGA (for example ML300 as it
ships) the development environment on Virtex-II Pro doesn't look different for
a SW person than on any other microprocessor based board.

Building the board itself is the same amount of work as for other chips.

Building the bitstream for the FPGA definitely is an additional step. However,
the EDK web page has some example designs that get you started in a short
amount of time.

> 2.) Is there any big caveats I should now about for debugging bring up?

If you keep the design close to the ML300 design (schematics available) you
will be able to use the Linux kernel for ML300 and by just configuring the
kernel bring the board up in a short amount of time.

> 3.) Does anybody know about vxworks 'support' for this as well?

Not the appropriate list - I know - but VxWorks support exists as well.

> 4.) Is debugging support with BDI, vision ICE, etc there yet for this
> board? Is it just good old JTAG or something different?

Yes, it is standard JTAG. So far, any external debuggers I've used that claim
support for 405GP have worked out of the box on Virtex-II Pro (BDI2000,
RiscWatch, VisionProbe, VisionICE, Lauterbach, ...).

> 5.) Is this chip even mature yet?

It's in production. We have Virtex-II Pro based systems here at Xilinx that run
(uptime) Linux under load (web server, streaming MP3, etc.) for more than sixty
days.

- Peter

------
PS: some links for things mentioned in the text
- ML300: http://www.xilinx.com/ml300
- EDK: http://www.xilinx.com/edk
- Linux on Virtex-II Pro:
http://www.mvista.com/partners/semiconductor/xilinx.html


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
