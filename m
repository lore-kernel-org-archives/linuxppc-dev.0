Date: Fri, 16 May 2003 16:58:49 -0700
Subject: Re: Virtex II Pro eval Boards
Content-Type: text/plain; delsp=yes; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linuxppc-embedded@lists.linuxppc.org
To: emanuel stiebler <emu@ecubics.com>
From: bob piatek <bobtek@fishcamp.com>
In-Reply-To: <3EC568D2.6020905@ecubics.com>
Message-Id: <5668A00E-87FA-11D7-AD26-000393D6CBAE@fishcamp.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Insight electronics has a V2Pro evaluation card that is bare bones:

http://www.insight.memec.com/cgi-bin/bvutf8/memec/scripts/local/
mc_loc_b.jsp?Div=INSIGHT&Reg=AMERICAS&Country=UNITED_STATES&Lang=EN&isDe
tailPage=true&EDOID=200910&Manu=MD_XILINX


It's a lot cheaper than the Xilinx ML300 but, of course, doesn't do as
much.  You can get daughter cards for it to support things like
Ethernet, CompactFlash, etc.  I understand that 'Mind' has ported
PPCBoot and Linux to the card:

http://mind.be/library/software/


Xilinx has a OPB to PCI bridge that supports their PCI core but it
doesn't (yet) support host applications.  Right now the bridge requires
a license to use but I understand that if you already have a license to
their PCI core then you automatically qualify for the OPB-PCI bridge.
At least that's what my FAE has told me.  I am just getting into a PCI
design with the chip so I don't have any direct experience to relate.

Bob

fishcamp engineering
105 W. Clark Ave.
Orcutt, CA  93455

http://www.fishcamp.com
TEL: 805-937-6365
FAX: 805-937-6252


On Friday, May 16, 2003, at 03:40 PM, emanuel stiebler wrote:

>
> Hi,
> I remember few people out here talking about the VirtexIIPro. What Eval
> Boards did you use ? Experiences ?
>
> Anybody used the VirtexIIPro with a PCI-Bridge ?
>
> cheers & thanks in advance
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
