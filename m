Date: Tue, 21 Jan 2003 20:56:06 -0500 (EST)
From: jgdon <jgdon@gomba.ca>
To: Rod Boyce <rod_boyce@stratexnet.com>
Cc: "'James Don'" <JDon@spacebridge.com>,
	"" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: My Memory map ... how do i pick the virtual address (Aside fr
 om i mmr and sdram)
In-Reply-To: <8D7C5F56B409554D9D46AC22195807F3061C21@exchwenz01.dmcwave.co.nz>
Message-ID: <Pine.LNX.4.50.0301212052210.30811-100000@gomba.ca>
References: <8D7C5F56B409554D9D46AC22195807F3061C21@exchwenz01.dmcwave.co.nz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
> located at 0.  We have placed IMMR at 0xfa200000.  The address of 0xc0000000
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
