Message-ID: <8D7C5F56B409554D9D46AC22195807F3061C21@exchwenz01.dmcwave.co.nz>
From: Rod Boyce <rod_boyce@stratexnet.com>
To: "'James Don'" <JDon@spacebridge.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: My Memory map ... how do i pick the virtual address (Aside fr
	om i mmr and sdram)
Date: Wed, 22 Jan 2003 13:37:18 +1300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I think you have the wrong end of the stick.  Our boards have 32MB of RAM
located at 0.  We have placed IMMR at 0xfa200000.  The address of 0xc0000000
is a virtual address it does not have to have any relation to a physical
address this is done by the memory manager.  The only constant is that the
boot flash MUST be connected to chip select 0.  Everything else is mostly
software configurable.

Regards,
Rod Boyce.

 -----Original Message-----
From: 	James Don [mailto:JDon@spacebridge.com]
Sent:	Wednesday, 22 January 2003 12:58 p.m.
To:	linuxppc-embedded@lists.linuxppc.org
Subject:	My Memory map ... how do i pick the virtual address (Aside
from i mmr and sdram)


Hi,

I am just looking at adding my other mem mapped devices to Linux for my
custom MPC860 board ...

I know RAM has to be at 0xc0000000 and immr at 0xff000000 ... is there any
rule of thumb for anything else?

Jim


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
