Message-ID: <B895EFF5AF34724880036BDB5B5B8148135699@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'Scott Anderson'" <sanders@mvista.com>,
	"Kerl, John" <John.Kerl@Avnet.com>
Cc: ??? <nari_dhy@nari-china.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: bootstrap of virtex-ii pro eval board ML300
Date: Mon, 2 Jun 2003 13:48:17 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You're saying that the entire zvmlinux.initrd file
(2-3 MB, say) is contained in the FPGA bitstream??
I find that hard to believe ...

-----Original Message-----
From: Scott Anderson [mailto:sanders@mvista.com]
Sent: Monday, June 02, 2003 1:49 PM
To: Kerl, John
Cc: ???; linuxppc-embedded@lists.linuxppc.org
Subject: Re: bootstrap of virtex-ii pro eval board ML300


On Monday, June 2, 2003, at 01:41  PM, Kerl, John wrote:
> (2) Whether the bit file is obtained via System ACE or JTAG,
> the FPGA is initialized.  This includes populating the
> block RAM.
>
> Note that your block RAM will almost certainly not be
> big enough to contain your Linux kernel.  Sizes vary but
> in my experience they are measured in kilobytes -- e.g.
> 4KB to 64KB.  For this reason, it is preferable to have
> the ELF file that is contained in your bitstream be a *small*
> executable that can fit in the block RAM.  This small
> executable can *find* a larger executable (e.g. the Linux
> kernel image), from a flash device, compact flash, TFTP,
> etc., then load and run it.
>
Um, since he was asking about the ML300 specifically, my
experience on it is that the memory controller got initialized
along with everything else so that the ELF did not have to
fit in block RAM; rather the ELF got slammed right into
the 128MB of DDR SDRAM.

   Scott

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
