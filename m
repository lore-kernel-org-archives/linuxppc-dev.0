Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id AA48EDDEC6
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jun 2007 09:09:20 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch 00/13] CPU selection Kconfig cleanup, take 3
Date: Mon, 18 Jun 2007 01:09:10 +0200
References: <20070612163016.253915076@arndb.de>
	<200706170214.11247.arnd@arndb.de>
	<4E0AC3E6-98F8-40BD-BA85-60766E097E4A@kernel.crashing.org>
In-Reply-To: <4E0AC3E6-98F8-40BD-BA85-60766E097E4A@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706180109.11482.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 17 June 2007, Kumar Gala wrote:
> I commented on some minor nits with the patches. =A0I'm probably ok =A0
> with patches 1-7 going in. =A0I'm not ready for 8 at this point, we =A0
> need to do more proper cleanup to get 85xx/cpm2 support into a =A0
> multiplatforms single kernel state.

Ok, makes sense. I've fixed up the other patches according to
your comments (did not change 8xx stuff though) and pushed
it out to
git://git.kernel.org/pub/scm/linux/kernel/git/arnd/cell-2.6 powerpc-kconfig

Paul, please pull from there, I'll remember not to try messing with
32 bit in the future but wanted to get this in after spending so
much work on it.

	Arnd <><
