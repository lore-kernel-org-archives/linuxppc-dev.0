Message-ID: <8D7C5F56B409554D9D46AC22195807F3061C22@exchwenz01.dmcwave.co.nz>
From: Rod Boyce <rod_boyce@stratexnet.com>
To: "'jgdon'" <jgdon@gomba.ca>
Cc: "'James Don'" <JDon@spacebridge.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: My Memory map ... how do i pick the virtual address (Aside fr
	 om i mmr and sdram)
Date: Wed, 22 Jan 2003 14:04:33 +1300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I can tell you now the mapping between physical and virtual not as important
as you make out.  I have Linux running on a board I described to you and
there is no RAM mapped at 0xc0000000.  I suggest you read your chip manual
more carefully.  In my 860 PowerQUICC Users manual chapters 13,14 and 16.

I also remember reading somewhere at IO should be mapped above 0x80000000
but I have not been able to find where I read it in the last two years so
that could be another urban myth that need the cold light of day on it.

Regards,
Rod Boyce

 -----Original Message-----
From: 	jgdon [mailto:jgdon@gomba.ca]
Sent:	Wednesday, 22 January 2003 2:56 p.m.
To:	Rod Boyce
Cc:	'James Don'; linuxppc-embedded@lists.linuxppc.org
Subject:	RE: My Memory map ... how do i pick the virtual address
(Aside fr om i mmr and sdram)

Hi,
I think the the mapping of virtual to physical address may be important
... i believe ram should be at 0xc0000000 for a number of reasons ...
there is lots of posts regarding this ...

What I am worried about is "rules of thumb" for example i have an ASIC on
cs4 ... at BR4 0x08000000 ... I would like to map it to 0x08000000 in the
MMU ... i would just like to be sure this is an ok address to check ... or
if there is some generally accepts address range for "non memeory" device
stuff ... I assume 'no' ... but i also assume the immr address and sdram
address didn't matter at one time ...

Jim

On Wed, 22 Jan 2003, Rod Boyce wrote:

>
> I think you have the wrong end of the stick.  Our boards have 32MB of RAM
> located at 0.  We have placed IMMR at 0xfa200000.  The address of
0xc0000000
> is a virtual address it does not have to have any relation to a physical
> address this is done by the memory manager.  The only constant is that the
> boot flash MUST be connected to chip select 0.  Everything else is mostly
> software configurable.
>
> Regards,
> Rod Boyce.
>
>  -----Original Message-----
> From: 	James Don [mailto:JDon@spacebridge.com]
> Sent:	Wednesday, 22 January 2003 12:58 p.m.
> To:	linuxppc-embedded@lists.linuxppc.org
> Subject:	My Memory map ... how do i pick the virtual address (Aside
> from i mmr and sdram)
>
>
> Hi,
>
> I am just looking at adding my other mem mapped devices to Linux for my
> custom MPC860 board ...
>
> I know RAM has to be at 0xc0000000 and immr at 0xff000000 ... is there any
> rule of thumb for anything else?
>
> Jim
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
