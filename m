Date: Tue, 24 Jul 2001 10:44:32 -0500 (CDT)
From: Grant Erickson <erick205@umn.edu>
To: Cindy Peters <cinpet@adaptivemicro.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: New Linux PowerPC development
In-Reply-To: <A109131318C4D1119AC20060088DECE35732DF@mail.adaptivemicro.com>
Message-Id: <Pine.SOL.4.20.0107241039250.21414-100000@garnet.tc.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 24 Jul 2001, Cindy Peters wrote:
> I am looking for some advice on the best PowerPC processor to use for
> a new embedded board design. Some features that the board needs to
> support is a hard drive ( i.e. IDE), 10/100BaseT Ethernet support, and
> a large size of RAM (maybe about 1GByte or more). We have previously
> completed a design using the MPC823 so we have the experience and the
> code available as far as the initialization of the processor, boot
> code, ramdisk, and Linux kernel. The MPC823, however, does not have an
> IDE or PCI interface for a hard disk. We feel we would have to design
> an interface into an FPGA. It doesn't support 100BaseT either. We are
> also looking at using either the MPC8260/MPC8265 or the IBM 405GP. I
> have been browsing through the mailing-list archives and have seen
> that these processors are both widely used. I would like some feedback
> from people that have experience in using these processors with Linux
> and what recommendations they have.

Cindy,

I've been engaged in several PowerPC 405GP projects since IBM was at
Rev. A silicon and the hardware itself has come along nicely to date (now
at Rev. E) and has proven to have been an excellent choice in those
projects. Of particular benefit is the system integration it affords with
the PCI bridge, I2C controller, serial controller, SDRAM controller, and
Etherner MAC all on-chip.

As for software support, the GCC line (2.95.x is all I've used) and
binutils line all support the processor quite well. So, general
development should be a non-issue.

As others here have intimated, Linux support is pretty good, depending on
which kernel release you're using; however, it's still a bit bleeding edge
at this point and doesn't appear to have smoothly integrated itself into
the main PowerPC source tree. But, people are working hard on that issue
as I understand and this should fall into place in short time.

Regards,

Grant Erickson


--
 Grant Erickson                       University of Minnesota Alumni
  o mail:erick205@umn.edu                                 1996 BSEE
  o http://www.umn.edu/~erick205                          1998 MSEE


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
