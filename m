Date: Thu, 05 Jun 2003 08:16:41 -0700
From: Peter Ryser <Peter.Ryser@xilinx.com>
Subject: Re: bootstrap of virtex-ii pro eval board ML300
To: NARI_DHY <nari_dhy@nari-china.com>
Cc: Peter Ryser <Peter.Ryser@xilinx.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Message-id: <3EDF5ED9.9C5A46AF@xilinx.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <384EB15A-953C-11D7-85A6-000A959CAB7C@mvista.com>
 <3EDE222B.38CBF@xilinx.com> <001101c32b21$1bb5f2d0$4c44900a@hydingnb>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


System ACE CF.

- Peter


NARI_DHY wrote:

> > As Scott describes correctly the preferred method of booting ML300 is through
> > System ACE CF. System ACE CF reads ACE files and programs the FPGA and the
> > PowerPC processor through the JTAG chain.
> System ACE CF reads one of the .ace files (at most 8) from the first partition of FAT16/FAT12 fs.
>
> > On power-up or reset System ACE CF reads the ACE file from the MicroDrive or
> > CompactFlash card and in a first step programs the FPGA. Then, in a second
> > step, from the same ACE file, it programs the processor, i.e. similar to an
> > external debugger it loads code and data contained in the ELF file into the
> > processor memories, sets the PC to the start address, and starts executing the
> > program.
> >
> what is this "it"? Is it System ACE CF or other small executive edited by developper?
>
> -hyding
>
> best regards
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
