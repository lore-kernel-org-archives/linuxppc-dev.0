To: linuxppc-dev@lists.linuxppc.org
Subject: Re: ppc LE questions (seeking help hand info pointers)
References: <200109211848.f8LImlT19616@saturn.cs.uml.edu>
From: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
Date: 22 Sep 2001 16:23:44 +0200
In-Reply-To: "Albert D. Cahalan"'s message of Fri, 21 Sep 2001 14:48:47 -0400 (EDT)
Message-ID: <8xu1xvi9sf.fsf@s63.informatik.uni-bremen.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Albert D. Cahalan" <acahalan@cs.uml.edu> writes:

[...]
> Now do an unconditional 64-bit byte swap on the motherboard.
> Consider an array of four __u16 values affected by this.
> They get converted from big-endian to little-endian, and they
> get moved to different addresses. Excellent! All the weirdness
> just cancels out, giving perfect little-endian. This works for
> 8-bit, 16-bit, 32-bit, and 64-bit data. Life is good.
>
Does it work for 128 bit data? The 74x0's most promiment feature,
AltiVec, would expose a strange mixed endianness to programmers
otherwise.

  Holger


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
