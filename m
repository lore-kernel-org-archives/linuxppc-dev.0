Message-Id: <200109041415.KAA27697@orchid.cspi.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Brian Waite <bwaite@cspi.com>
Reply-To: bwaite@cspi.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mvme5100 one more time...
Date: Tue, 4 Sep 2001 10:06:59 -0400
References: <85256ABC.00556948.00@pine.cspi.com>
In-Reply-To: <85256ABC.00556948.00@pine.cspi.com>
MIME-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Xavier,
	Just a quick sanity check, are all the jumpers at factory default and have
you changed any env settings? Just a thought.

Thanks
Brian

On Monday 03 September 2001 11:32 am, you wrote:
> Le sam, 01 sep 2001 01:29:04, Tom Rini a
> écrit :
> > And if this fails, I just thought of one more thing (I need some hw I can
> > test this on locally...).
> > Look for:
> >    bl   flush_instruction_cache
> > And add #if 0/#endif around that and try again...
>
> I have done a pull this morning and applied your patchs. I have the same
> results even
> after the bl   flush_instruction_cache suppression.
>
> Here is the result :
> Network Boot File load in progress... To abort hit <BREAK>
>
> Bytes Received =&701661, Bytes Loaded =&701661
> Bytes/Second   =&701661, Elapsed Time =1 Second(s)
>
> Exception: Program (Illegal Instruction)
> SRR0 =001F0000 SRR1 =00083040 Vector-Offset =00700
> IP     =001F0000 MSR    =00003040 CR     =00000000 FPSCR  =00000000
> R0     =00000000 R1     =03F00000 R2     =00000000 R3     =00000000
> R4     =00000000 R5     =49504C01 R6     =00007000 R7     =001F0000
> R8     =03F0CF54 R9     =03F0CD54 R10    =03F0CD60 R11    =03F0CE54
> R12    =03F0CE54 R13    =00000000 R14    =00000000 R15    =00000000
> R16    =00000000 R17    =00000000 R18    =00000000 R19    =00000000
> R20    =00000000 R21    =00000000 R22    =00000000 R23    =00000000
> R24    =00000000 R25    =00000000 R26    =00000000 R27    =00000000
> R28    =00000000 R29    =00000000 R30    =00000000 R31    =00000000
> SPR0   =00000000 SPR1   =00000000 SPR8   =00000000 SPR9   =00000000
> 001F0000 00040000  WORD        $00040000
>
> The board don't have any disk or system for the moment, perhaps this is the
> problem ?
> I just want to try to boot now... Because I have also a mvme2303 with a
> whole debian
> system on it. So if I have a kernel for the mvme5100 I will only need to
> put my
> SCSI PMC to have a complete system.
>
> O+ xavier

--
Brian Waite

Looking for a TeraFLOP in a closet
www.fastcluster.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
