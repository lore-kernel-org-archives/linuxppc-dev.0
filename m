Date: Wed, 8 Oct 2003 07:49:40 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: maurie <maurie@risc.sps.mot.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Vga on sandpoint
Message-ID: <20031008144940.GA29203@ip68-0-152-218.tc.ph.cox.net>
References: <000a01c38ce9$4c8ec740$9b7c520a@sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000a01c38ce9$4c8ec740$9b7c520a@sps.mot.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Oct 07, 2003 at 10:40:13AM -0500, maurie wrote:

> 	I am attempting to get pci vga working on the sandpoint platform
> using dink32 to start linux.  I have tried several S3 cards with no video
> success.  The kernel has vga driver support for SIS and ATI support, but
> these are classified as experimental and will not compile, undefined
> externals for __floatsidf, __divdf3, __adddf3, __fixunsdfsi, __muldf3, and
> __vmalloc.

I have used a Matrox Millenium I successfuly on a Motorola Sandpoint.
Newer cards, if you buy a PCI version, should also work.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
