Date: Wed, 12 Dec 2001 16:13:42 -0800
From: andrew may <acmay@acmay.homeip.net>
To: Kent Borg <kentborg@borg.org>
Cc: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Compile Penguin PPC for x386?
Message-ID: <20011212161342.C18785@ecam.san.rr.com>
References: <20011212165819.D1790@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011212165819.D1790@borg.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Dec 12, 2001 at 04:58:19PM -0500, Kent Borg wrote:
> But then it chokes on some problem in include/linux/highmem.h (48:
> parse error before `0').

We use to just pull out the section in the ifndef and things would
work on the 386, but then at some point the 386 kernel would just
hang. I have not been doing any builds recently so I have no idea
how things are going now.

#ifndef __HAVE_ARCH_USER_PAGE

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
