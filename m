Message-ID: <39879B21.A1D66679@amulet.co.jp>
Date: Wed, 02 Aug 2000 12:53:05 +0900
From: Hollis Blanchard <hollis@amulet.co.jp>
MIME-Version: 1.0
To: Thomas Graichen <graichen@innominate.de>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: USB keyboard problems - cdcd
References: <news2mail-8m5oaq$6tj$3@mate.bln.innominate.de>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thomas Graichen wrote:
>
> i have a little keyboard problem on my blueberry imac with the
> standard usb keyboard: whenever i type something very quickly
> followed by space the typed in will be repeated before the
> space (best example: i want to type "cd " and get "cdcd ")
> - this gets a bit annoying - does anybody have the same
> problem (or even a fix for it) ? - is it more a soft-
> wareproblem (i hope :-) or maybe a hardwareproblem ?
> (i had it on all kernels from 2.2.x to 2.4.0-testx)

This is well-known (at least for people with USB keyboards). Interestingly,
it *only* seems to happen with the old Apple USB mini keyboard (the fullsize
is too new; haven't heard anything about it).

The problem only seems to happen when some (not all) groups of three keys
are hit too quickly. It could be because this keyboard physically allows you
to press more keys simultaneously, or it could be driver-related (or both).

The only solution for now seems to be type "cd " one key a time.

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
