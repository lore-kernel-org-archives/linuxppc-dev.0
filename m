Message-ID: <3996BFBD.FD8DE0D7@erols.com>
Date: Sun, 13 Aug 2000 11:33:17 -0400
From: Nelson Abramson <pogtal@erols.com>
MIME-Version: 1.0
To: Josh Kindler <josh@antihype.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: atyfb problems?
References: <B5BC31B9.2C74%josh@antihype.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Josh Kindler wrote:

> Hmm... I jsut got the latest (as of last night) rsync of Ben's kernel. When
> I compiled it, I got the following error. Previous kernels compiled fine, is
> this a known issue or am I just stupid?
>
> atyfb.c:641: redefinition of `reset_GTC_3D_engine'
> atyfb.c:631: `reset_GTC_3D_engine' previously defined here

> <snip>

Try disabling ATI Mach support.

> Also I have an (AFAIK) unresolved airport problem:
> I can compile it fine, but then when I insmod it i get:
>
> airport.o: unresolved symbol isa_io_base

IIRC, this is in the list archives. (hint, search for the error)

HTH
--Nelson Abramson


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
