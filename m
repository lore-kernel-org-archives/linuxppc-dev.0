Date: Wed, 7 Apr 2004 17:18:53 +0200
From: Kiko Piris <linuxppc@pirispons.net>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.6.5/iBook G3: Oops on resume from sleep
Message-ID: <20040407151853.GA10891@mortadelo.pirispons.net>
References: <20040405215318.GA2822@mortadelo.pirispons.net> <20040405231321.GA1293@palantir8> <20040406073741.GA4008@fpirisp.portsdebalears.com> <20040406120158.GA7444@palantir8> <20040406124325.GA17046@fpirisp.portsdebalears.com> <20040406221848.GA1641@palantir8>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040406221848.GA1641@palantir8>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 06/04/2004 at 23:18, Martin Habets wrote:

> Well, I'm out of clues then. Must be something else affecting

No worries. As BenH pointed, I filed a bug at alsa-project bugtracking
page (no response yet).

> Probably not relevant, but does the input source in alsa mixer work
> okay for you?

What do you mean? If I can record sound with the mic? Yes I can.

In fact I had never used the mic that comes with the iBook before, I
just apt-get installed audacity and recorded something. OK, no problem.

The funny thing is that with alsa, playback is horrible (too low and
*very* poor quality). I just have both dmasound_pmac and alsa compiled
as modules[*] and I load those modules when I want to listen to some
audio file (sound is not a crucial issue for me).

[*] My system is set up so that oss's dmasound_pmac tries to get loaded
on boot. Then I've "hacked" a bit the modprobe.d configuration file for
alsa modules as you can see in [1]. When I want to disable alsa I just
put that #alsa.off# comment and, with that configuration, I can use oss
and disable alsa on-the-fly.

It's quite handy when, like now, alsa causes system hangs on waking up
from sleep; just disable it and be happy (as I said before, sound is not
a vital issue for me on my laptop).

[1] http://www.pirispons.net/bulma/llista/iBook/modprobe.d/kiko

Kind regards.

--
Kiko

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
