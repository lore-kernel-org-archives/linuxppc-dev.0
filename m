From: Joe Green <jgreen@mvista.com>
To: Wolfgang Denk <wd@denx.de>, Michael Habermann <MHabermann@gmx.de>
Subject: Re: Reducing glibc with mklibs.sh
Date: Wed, 17 Oct 2001 09:28:41 -0700
Content-Type: text/plain
Cc: linuxppc-embedded@lists.linuxppc.org
References: <20011017123040.23ED310889@denx.denx.de>
In-Reply-To: <20011017123040.23ED310889@denx.denx.de>
MIME-Version: 1.0
Message-Id: <01101709304900.12705@minotaur.mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:
> In message <5.1.0.14.0.20011017155249.03548ec0@pop.gmx.de> you wrote:
> >
> > If you know any other tools to do this task, please let me know. Seems that
> > LIPO (Lineo) and LOT(HardHat) are not free.
>
> What makes you think so?
>
> The MV Library Optimizer at
> http://sourceforge.net/projects/libraryopt/ it's under GPL.

Yes, but it's not well documented yet...I need to improve that and add
a mailing list.

Michael Habermann wrote:
> I tried to reduce the size of my self-compiled glibc 2.2.2, with the debian
> script mklibs.sh, but it terminates with the following output:
> ---
> /usr/local/powerpc-linux/bin/ld: /tmp/,mklibs.21079/lib-so: undefined
> versioned symbol name sys_siglist@@GLIBC_2.1

This looks like a problem with COPY relocation types, which was seen and
fixed for the LOT.

--
Joe Green <jgreen@mvista.com>
MontaVista Software, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
