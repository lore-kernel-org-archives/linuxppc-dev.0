Message-Id: <200004040659.CAA16921@shell.faradic.net>
Date: Tue, 04 Apr 2000 02:59:33 EDT
From: jingai <jingai@floatingpenguins.com>
To: "Geert Uytterhoeven <geert@linux-m68k.org>; jingai" <jingai@floatingpenguins.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Re: DMA Sound split & Atari800
Reply-To: jingai@floatingpenguins.com
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> On Mon, 3 Apr 2000, jingai wrote:
> > I am trying to build Atari800 (the emulator) with sound support, and so
far
> > I have been successful, except that the output is very 'jittery.'  It
>
> Did it work before you applied the dmasound split patches?

Actually, I *believe* it didn't.  I honestly didn't get it to work at all
before applying the patches (I found the SIGNED_SAMPLES and
POKEYSND_BIG_ENDIAN defines after patching), but I did later on boot to
what I *think* was a kernel before the patches... I say "think" because I'm
not entirely sure I didn't overwrite that kernel with the new patched
kernel at some point during this whole process.. but I am fairly sure that
it probably would have worked the same, and that this problem has always
been there (ie, you didn't introduce it, AFAIK).. so it's either a problem
with the sound implementation in LinuxPPC or in Atari800... but, since
Atari800 is primarily developed for the Atari Falcon (m68k, I believe) and
not x86 (although x86 support is certainly more carefully monitored than
PPC I'm sure), I'm not entirely sure where the problem lies..

.ugh, sorry for the rambling.. I just got off work and it's 3am already so
you'll have to excuse me.. :)  But, if anyone who does know more about
kernel hacking than myself would care to make some attempt at building
Atari800 I would really appreciate it.. I could send the latest sources
(0.9.9h) plus the required roms to whomever is willing to try.

Regards,
Jonathan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
