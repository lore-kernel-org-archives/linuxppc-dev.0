Mime-Version: 1.0
Message-Id: <v04220803b622eb4a1108@[10.0.0.42]>
In-Reply-To: <20001028172451.A10220@lx.c-side.com>
References: <39FB3C16.3359BC41@the-rileys.net>
 <20001028172451.A10220@lx.c-side.com>
Date: Mon, 30 Oct 2000 01:12:14 -0800
To: Neil Russell <caret@c-side.com>, David Riley <oscar@the-rileys.net>,
        linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: PPC byte ordering
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 5:24 PM -0700 10/28/00, Neil Russell wrote:

>It would in theory be possible to have the kernel run big-endian as it is
>and have certain user programs run little endian by setting the LE bit in
>the MSR register for the process in question.  The real problem here is
>that you have to add a *lot* of code to system calls to make this work.
>There are a few system calls that this would be real difficult, such
>as ioctl().  I once looked into doing this for the MIPS with SVR4 UNIX.

The other real problem is that Linus Torvalds has already said that
he will never ever in a million years accept a patch which attempts
to do such a thing, so you'd have to fork the kernel to do it.
According to Linus, architectures are either big or little-endian,
not both.  A sane position considering the syscall ugliness you
mention...

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
