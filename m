Date: Mon, 24 Apr 2000 12:17:54 -0400 (EDT)
From: Pavel Roskin <pavel_roskin@geocities.com>
To: kd@flaga.is
cc: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: zeroing of bss segments
In-Reply-To: <OF545F1DB8.1BC9109A-ON002568C3.00596043@flaga.is>
Message-ID: <Pine.LNX.4.21.0004241211280.30844-100000@sunapee.transcept.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

> I forgot to remove the memset.S file from sysdeps/powerpc....

I believe we should rewrite memset.S in a 8xx-safe way rather than remove
it. Patches are usually more visible than instructions to remove
something.

Besides, future versions of Glibc could apply that patch permanently.
Portability is a strong argument for GNU developers.

Anybody?

Pavel Roskin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
