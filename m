Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: Jim Thompson <jim@musenki.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15442.10795.560990.370617@gargle.gargle.HOWL>
Date: Fri, 25 Jan 2002 22:01:47 -0600
To: frederic.villeneuve@laposte.net
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Boot loader for Sandpoint3 with UnityX4 MPC8245
In-Reply-To: <3C4BFED40005C880@mail.laposte.net>
References: <3C4BFED40005C880@mail.laposte.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've got PPCboot 1.1.5 running on mine.  I don't think Wolfgang has my
patches installed in the tree yet.  I can forward them via email if
you like.

GBIOS also is supposed to run on the Sandpoint.

Jim

Frederic Villeneuve writes:
>
> Hello,
>
> I'm looking for a boot loader for the above configuration.
>
> So far I'm able to boot the system under DINK32, download a kernel via the
> serial port and boot the kernel with a root filesystem on a hard drive.
>
> I would like to be able to directly boot the Linux kernel when the system
> powers-up.
> Can anyone give me some advices on where to find a boot loader that would be
> compatible with the UnityX4 and MPC8245 ?
>
> Thanks
>
> Frederic Villeneuve


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
