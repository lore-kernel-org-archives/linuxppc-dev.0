Date: Tue, 29 Jan 2002 20:41:02 -0700
From: Val Henson <val@nmt.edu>
To: David Ashley <dash@xdr.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: BUG: udp socket, getsockopt + setsockopt
Message-ID: <20020129204102.A9094@boardwalk>
References: <200201300326.g0U3Qu600178@dave.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200201300326.g0U3Qu600178@dave.home>; from dash@xdr.com on Tue, Jan 29, 2002 at 07:26:56PM -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm not sure what version this change appeared.  Also, your pc may
have different default socket size settings.  This command will show
you both the max and default settings:

cat /proc/sys/net/core/?mem_*

(You can also set them in the usual way.)

-VAL

On Tue, Jan 29, 2002 at 07:26:56PM -0800, David Ashley wrote:
>
> I forgot to mention it doesn't act the same on my x86 desktop running
> linux. I don't recall what version. On my pc there is no trouble.
> Oh well.
>
> Thanks--
> Dave
>
> >When you set SO_RCVBUF with setsockopt, the kernel allocates twice the
> >memory you set.  This has something to do with BSD compatibility and
> >storing internal kernel structures in the memory allocated for the
> >recv buf.  Try getsockopt after you setsockopt.
> >
> >This is ostensibly a feature, not a bug.  Search the linux-kernel
> >archives for "so_rcvbuf" and "David Miller".  Hint: you probably won't
> >convince Dave to change his mind.
> >
> >-VAL
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
