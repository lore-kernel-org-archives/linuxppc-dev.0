Message-ID: <3977006E.1A7E8151@biophys.uni-duesseldorf.de>
Date: Thu, 20 Jul 2000 15:36:46 +0200
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
CC: Rolf Liu <rolfl@sc23.sc.mcel.mot.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: problems about __cli()
References: <200007200919.KAA12257@hyperion.valhalla.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:
> the function is implemented in:
>
> /usr/src/your-kernel-foo-bar/arch/ppc/kernel/misc.S
>
> It is *vital* to make sure that there is a symlink named 'linux' in /usr/src
> that points to your /usr/src/your-kernel-foo-bar/ because there are symlinks
> in /usr/include that expect to use this to find the build-specific headers.

Wasn't that the same guy that tried to build Linux kernels on a Windoze
system? The whole /usr/src and symlink stuff might be a bit tough to
pull off on such a box.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
