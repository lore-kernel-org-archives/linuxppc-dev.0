Date: Wed, 19 Jul 2000 12:18:42 -0400
From: Dan Foster <dsf@gblx.net>
To: Tim Wojtulewicz <Tim.Wojtulewicz@NAU.EDU>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Panic while building XFree86
Message-ID: <20000719121842.A17734@frontiernet.net>
References: <p04301800b59b829649df@[209.147.134.139]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <p04301800b59b829649df@[209.147.134.139]>; from Tim.Wojtulewicz@NAU.EDU on Wed, Jul 19, 2000 at 09:07:37AM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hot Diggety! Tim Wojtulewicz was rumored to have wrote:
>
> I've been trying to compile XFree86 4.0.1 recently (tried 4 times
> already) and my computer keeps throwing kernel panics whenever I do
> so.  It usually happens after the compile has been going for a while.
> I think it has something to do with the fan coming/not coming on, but

Sounds exactly like it. Run, don't walk, and fix that :)

kernel panics due to compiler failure tend to indicate either a flaky
motherboard (found one with substandard traces, VRM, etc) or more commonly,
an overheated CPU; fan failure is a real common cause for this. Tends to
get exercised with compiling large stuff - kernel, XFree86, mozilla, etc
as it heats up and experiences bit flips. (hence, invalid locations,
instruction pointer running in wrong places, insta-crash)

This isn't a Linux specific problem per se; I've seen it with BSD boxes, too.

-Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
