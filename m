From: v.sudeep@exgate.tek.com
Message-ID: <301A812E6528D511A8F70008C71E578602B6D857@ap-bang-m02.india.tek.com>
To: samsongshzu@yahoo.com.cn, wd@denx.de, xmiville@oerlikon.ca,
	mporter@kernel.crashing.org, laurent.mohin@acterna.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: PCI daughter card with USB on a 405GP 
Date: Thu, 26 Feb 2004 06:05:20 -0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi !!!

Thanks all for your response... I apologise profusely for the delay in
responding....

I did go through all of your responses and this is what I did ...

1.  lspci -vvx  : the following is the output.  I still am finding out how
to understand this..
00:00.0 Host bridge: IBM 405GP PLB to PCI Bridge (rev 01)

        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 7

        Interrupt: pin A routed to IRQ 0

        Region 1: Memory at <unassigned> (32-bit, prefetchable)

        Capabilities: [58] Power Management version 2

                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00: 14 10 56 01 06 00 10 22 01 00 00 06 00 07 00 00

10: 00 00 00 00 08 00 00 00 00 00 00 00 00 00 00 00

20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

30: 00 00 00 00 58 00 00 00 00 00 00 00 00 01 00 00


2. ==== arch/ppc/mm/cachemap.c
I found that this file does not exist at all in the montevista Hard hat
Linux ver 2.0.  So I downloaded ver 3.0 as a preview kit and I am checking
to see if it exists ... I suppose it does... I have made the changes
suggested. But have not able to bring it to a workable state.

3. I downloaded and built the tool chain for the 405GP. And am running into
problems trying to compile the linux 2.4.22 kernel. I am not sure of what I
must do to create the treeboot image... I think by default it does not do
it.. it creates only the vmlinux.gz

4.  Both ALi and OPTi are having OHCI support

 I am in the process of procuring a Adaptec card to see if it could make a
difference for me...

- S u d e e p    V
When so many are lonely as seem to be lonely, it would be inexcusably
selfish to be lonely alone.

-----Original Message-----
From: song sam [mailto:samsongshzu@yahoo.com.cn]
Sent: Tuesday, February 24, 2004 8:09 PM
Subject: Re: PCI daughter card with USB on a 405GP

Wolfgang Denk wrote:
> We tested a Adaptec AUA-200LP USB 2.0 card in some PPC sytems. It
> worked fine when the devices were already connected at power-on or
> at least when booting Linux, while hot-plug would reliably crash the
> kernel. As far as I understand such behaviour is typical of some of
> the alignment/cache bugs in the Linux kernel's USB code.

I also met this USB problem on LITE_DW board when using USB keyboard and
mouse.Has it solved or not?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
