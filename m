To: linuxppc-dev@lists.linuxppc.org
Subject: Re: fetch_and_add() available on PPC Linux?
References: Message from rayson_ho@hongkong.com of "Thu, 06 Dec 2001 11:56:48
	+0800." <gM988793884351.18059@mail1.hongkong.com>
	<l03130301b8351d769a73@[192.168.1.2]>
From: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
Date: 06 Dec 2001 14:46:11 +0100
In-Reply-To: "Michael R. Zucca"'s message of Thu, 6 Dec 2001 08:07:41 -0500
Message-ID: <8xpu5s797g.fsf@s62.informatik.uni-bremen.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Michael R. Zucca" <mrz5149@acm.org> writes:

[...]
> The only caveat is that the ptr to any two of these items must be in
> individual lock granules. If the software has an array of locks that are
> just a bunch of long-words, there's going to be difficultly. However, given
> that this was an AIX box, and was probably a POWER machine, it's likely
> that the POWER machine has the same lock granule restriction.
>
> See the PPC manual for the lock granule size. I forget what it is off the
> top of my head.
>
It is architected to be one cache block. On the 'desktop' PowerPCs (6xx, 7xx,
7xxx) that currently means 32 bytes. Some embedded models (4xx, 5xx?) have
cache blocks of 16 bytes.

  Holger


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
