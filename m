Message-ID: <3D831FFF.84380C87@koffie.nl>
Date: Sat, 14 Sep 2002 13:39:43 +0200
From: Segher Boessenkool <segher@koffie.nl>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: RFC: Performance Monitor Counters device
References: <3D80F2F7.3FB3AE4B@koffie.nl> <20020913100402.GC10515@krispykreme>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Anton Blanchard wrote:
> It would be great if we could plug into something like oprofile.
> Linus was even interested in merging some sort of simple profiling
> infrastructure.
>
> We have a similar issue on ppc64, if we could share at least part
> of it between ppc32 and ppc64 that would be nice.

Some parts of the interface, like the raw/cooked counter reading and
the simplest forms of profiling interrupts, can probably be shared
across all architectures; ppc32 and ppc64 can probably share about
everything.


Segher


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
