Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "'Torben Mathiasen'" <torben.mathiasen@hp.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Anyone using uClibc on a 405GP platform?
Date: Tue, 24 Feb 2004 13:21:44 +0100
Message-ID: <002d01c3fad0$c6b220d0$0a01a8c0@LUMENTIS02>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <20040224114648.GC2970@tmathiasen>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> On Tue, Feb 24 2004, Torben Mathiasen wrote:
> >
> > Hi,
> >
> > Does anyone successfully use uClibc on a 405GP platform? I
> tried compiling
> > uClibc but all my dynamic apps just segfault. Its the
> shared library loader
> > that segfaults immediately after execve(). I tried both a
> recent 2.4 and 2.6
> > kernel with the same result. Also using latest 0.9.26 uClibc.
> >
> > Has anyone gotten this to work?
> >
>
> Funny, I got this to work. I was under the assumption that
> one should be able
> to execute the library loader directly, which has never
> worked for me on
> powerpc. But a dynamic linked application seems to be working
> now. Both those
> I compiled myself and the ones I got from the root_fs_powerpc fs.

hmm, not sure about executing ldso directly, you may have better luck asking
about that on the uClibc list.

ldso is however somewhat broken. Lots of stuff/fixes has been added
since the last release.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
