Date: Mon, 2 Jun 2003 13:49:07 -0700
Subject: Re: bootstrap of virtex-ii pro eval board ML300
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: ??? <nari_dhy@nari-china.com>,
	linuxppc-embedded@lists.linuxppc.org
To: "Kerl, John" <John.Kerl@Avnet.com>
From: Scott Anderson <sanders@mvista.com>
In-Reply-To: <B895EFF5AF34724880036BDB5B5B8148135698@amer22.avnet.com>
Message-Id: <A73D055C-953B-11D7-85A6-000A959CAB7C@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
