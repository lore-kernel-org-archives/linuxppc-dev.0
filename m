Message-ID: <3C4F3E5E.80805@embeddededge.com>
Date: Wed, 23 Jan 2002 17:51:10 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: "Gessner, Matt" <mattg@aiinet.com>
Cc: "'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: BDI2000 and failed MMU translations
References: <638AA0336D7ED411928700D0B7B0D75BB32414@mail2.aiinet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Gessner, Matt wrote:

> It's straight 2_4.  I wasn't stopping at start_kernel though.

You don't need to stop anywhere unless there are some breakpoints
you want to set for early debug.

> I don't have PTBASE set up.

You need:
	MMU XLAT 0xc0000000
	PTBASE 0x000000f0

The newer kernels initialize the page table pointers for the BDI2000,
so ignore comments about stopping and setting values.  We went through
several iterations of implementation, so anything written about how to
do this manually is probably wrong :-).

> ...... I'm going to
> break at start kernel FIRST, then connect with BDI, then
> see if I can look at my data.

How do you break and then connect the BDI?  You need the BDI
connected to set and trap the breakpoint.

Have fun.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
