Date: Mon, 1 Apr 2002 13:21:12 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Linux-galileo] ev64260 bi_rec patch
Message-ID: <20020401202112.GA23326@opus.bloom.county>
References: <20020401185335.GA23174@opus.bloom.county> <0204011952.AA28527@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0204011952.AA28527@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Apr 01, 2002 at 11:52:16AM -0800, Michael Sokolov wrote:
>
> Tom Rini <trini@kernel.crashing.org> wrote:
>
> > What we need is
> > something like how we save Motorola residual data or bd_info stuffs
> > (memcpy in platform_init).
>
> Both of those structures are fixed-length and are copied to static variables.
> The bi_recs list has a variable length and can't be copied to a static variable
> (unless we agree on a maximum size for it and make a static buffer of that
> size, but someone other than me has to make that decision), and I don't know
> how to make a dynamic memory allocation that early.

We do it on OF boxes to save the device-tree.
--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
