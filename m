Date: Fri, 13 Sep 2002 20:04:02 +1000
From: Anton Blanchard <anton@samba.org>
To: Segher Boessenkool <segher@koffie.nl>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: RFC: Performance Monitor Counters device
Message-ID: <20020913100402.GC10515@krispykreme>
References: <3D80F2F7.3FB3AE4B@koffie.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D80F2F7.3FB3AE4B@koffie.nl>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I'm currently implementing a Linux driver to use the PowerPC
> performance monitor counters (PMC's).  I thought I'd ask here
> about some design/implementation issues, before I do a lot
> of stupid/timewasting things ;)

It would be great if we could plug into something like oprofile.
Linus was even interested in merging some sort of simple profiling
infrastructure.

We have a similar issue on ppc64, if we could share at least part
of it between ppc32 and ppc64 that would be nice.

Anton

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
