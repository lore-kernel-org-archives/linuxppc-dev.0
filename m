Date: Sat, 5 May 2001 20:49:08 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Subject: Re: Success! (was Re: External Monitor under Pismo)
In-Reply-To: <20010505010318.5183@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.10.10105052046290.26350-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >Please do - I tried Ben's mirror utility on the Lombard but no success.
> >And I still have no aty docs to look up the details in.
>
> Well, if you do that, it may be interesting to impement the same
> ioctls I have in my aty128fb version (I'll send it to you later
> if you don't want to rsync down my entire tree).

Please do; I'll have to re-sync eventually but I wouldn't mind a preview.

> I beleive you can do something very similar by just toggling the
> CRT & LCD enable bits on the first CRT. No need for CRTC 2 for
> simple mirroring. "Smart" mirroring (with higher refresh rate) would
> require use of CRTC2 however.

I tried to tweak the CRT and LCD regs on the first CRT before, based on
what I could guess from the mirror source and the kernel headers. Needless
to say - no success.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
