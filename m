Return-Path: <davej@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id CDAEADDF0E
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 14:27:48 +1000 (EST)
Date: Wed, 16 Jul 2008 00:20:42 -0400
From: Dave Jones <davej@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [git pull] Please pull from powerpc.git merge branch
Message-ID: <20080716042042.GA13212@redhat.com>
References: <1216172043.7740.136.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1216172043.7740.136.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	akpm <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 16, 2008 at 11:34:03AM +1000, Ben Herrenschmidt wrote:
 > Linus,
 > 
 > I apologize in advance for the couple of merge commits in there. I
 > merged your tree yesterday in order to fix a (fairly minor) conflict,
 > and waited for our autobuilder to test a whole bunch of configs
 > overnight before asking you to pull, at which point, sfr informed me of
 > a bunch of this time non-trivial conflicts with whatever you pulled in
 > the meantime...
 > 
 > So here it is with 2 merge csets at the top, I'll try to do better next
 > time. I don't want to rebase or my sub-maintainers will hate me.
 > 
 > So please pull from:
 > 
 > git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Boom!

arch/powerpc/platforms/built-in.o: In function `ep8248e_mdio_probe':
/builddir/build/BUILD/kernel-2.6.26/linux-2.6.26.ppc/arch/powerpc/platforms/82xx/ep8248e.c:129: undefined reference to `alloc_mdio_bitbang'
/builddir/build/BUILD/kernel-2.6.26/linux-2.6.26.ppc/arch/powerpc/platforms/82xx/ep8248e.c:143: undefined reference to `mdiobus_register'

.config is at http://davej.fedorapeople.org/kernel-2.6.27-ppc.config

	Dave

-- 
http://www.codemonkey.org.uk
