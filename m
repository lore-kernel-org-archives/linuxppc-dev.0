Return-Path: <sven@powerlinux.fr>
Received: from archon.plz.fr (archon.plz.fr [194.50.78.210])
	by ozlabs.org (Postfix) with ESMTP id C5A24DE314
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 04:05:42 +1100 (EST)
Date: Wed, 9 Jan 2008 18:05:40 +0100
From: Sven Luther <sven@genesi-usa.com>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: add phy-handle property for fec_mpc52xx
Message-ID: <20080109170540.GA6789@powerlinux.fr>
References: <20080109140608.GA15673@aepfle.de> <4784E78C.40904@genesi-usa.com>
	<20080109153511.GA5086@powerlinux.fr>
	<4784F695.7050507@genesi-usa.com>
	<20080109162923.GA6290@powerlinux.fr>
	<4784F803.9030003@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4784F803.9030003@genesi-usa.com>
Cc: Sven Luther <sven@genesi-usa.com>, Olaf Hering <olaf@aepfle.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 09, 2008 at 04:36:19PM +0000, Matt Sealey wrote:
> 
> Sven Luther wrote:
> >On Wed, Jan 09, 2008 at 04:30:13PM +0000, Matt Sealey wrote:
> >>Sven Luther wrote:
> >>>Let's just fix this in the kernel, until we get a fixed efika firmware,
> >>>then we can drop it easily enough. But until this happens, we need to be
> >>>able to boot the kernel without any extra work on the users part.
> >>That is exactly why I don't like the idea. Yes, it makes it easier for 
> >>users
> >>and easier for distro managers to say "it supports the Efika" but it makes
> >>the Forth fixing, and any further firmware development (ignore the lack of
> >>releases, it means nothing) much harder.
> >
> >efika firmware development is dead. Until we see a release we should
> >assume that the efika is a firmware with breakage, and no upstream
> 
> The link that Olaf presented, www.powerdeveloper.org/asset/by-id/46 *is*
> the upstream support for now. What his patch does is say, the upstream
> support exists, but we don't like it, so we will supplement the patch..

Matt, your work on efika.forth is laudable, and it is nice that you took
the time to support it.

*BUT* it is not acceptable for a distribution, or for someone who will
have to do user support, to have to launch a second binary before
launching the kernel. Especially when netbooting for example.

Friendly,

Sven Luther
