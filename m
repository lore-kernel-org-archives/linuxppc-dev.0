Subject: Kernel sound problems (and misc)
From: Bastien Nocera <hadess@hadess.net>
To: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Content-Type: text/plain
Date: 13 May 2001 16:40:59 +0100
Message-Id: <989768459.4941.0.camel@kara>
Mime-Version: 1.0
Message-ID: <kara.5052-0.989768459@kara.hadess.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi gang,


I updated my kernel today, trying out BenH's tree and Paulus' off
PenguinPPC's rsync services.

Ben's tree seems to already include Iain's dmasound patches, and showed
the same problem as when I applied the patches on an older kernel: when
booting (ie. when the sound is activated), the speakers are "hissing"
until I play something and stop it. Then it behaves correctly (ie.
there's no sound when I'm not playing any :P)

OK, there goes the main problem: mixer problems. There are 3 ways to
output sound on this iMac DV summer 2000 (OF tree still available from
tidbit.org).
- the front speakers: the preferred way obviously. Main volume is of no
use (doesn't do anything), the speakers volume goes from mute, or loud
to very loud.
- the front audio sockets: there aren't independant of the front
speakers, doesn't really matter, but that means it's not possible to
shut the sound of the speakers and listen to the music with a headphone.
It might be a hardware problem.
- the audio socket for external speakers on the left handside of the
machine: there's no volume control for them. Bringing down all the
volume controls shut off the front speakers (good), but there's no way
to raise or lower the sound on this output either.

So, to sum it up, the main volume control does absolutely nothing on
this machine, and the speaker volume control is either mute, loud, or
very loud. I'd be glad to help on finding out the problem.

The misc problem is, while trying to compile paulus' kernel, the vmlinux
target fails to link with rwsem_down_write_failed and rwsem_wake
undefined references.

I hope somebody can help me tackle these.

Cheers

--
/Bastien Nocera
http://hadess.net


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
