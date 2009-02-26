Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 96D77DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Feb 2009 07:30:32 +1100 (EST)
Subject: Re: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20090226112818.GF19612@zod.rchland.ibm.com>
References: <1235621244.8805.340.camel@pasglop>
	<20090226112818.GF19612@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Fri, 27 Feb 2009 07:30:21 +1100
Message-Id: <1235680221.7388.17.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-02-26 at 06:28 -0500, Josh Boyer wrote:
> On Thu, Feb 26, 2009 at 03:07:24PM +1100, Benjamin Herrenschmidt wrote:
> >Hi Linus !
> >
> >Please pull a few regression fixes for powerpc.
> >
> >Cheers,
> >Ben.
> >
> >The following changes since commit 169d418b127b98a3e464e9c4b807ad083760f98c:
> >  Linus Torvalds (1):
> >        Merge branch 'for-linus' of git://git.kernel.org/.../tiwai/sound-2.6
> >
> >are available in the git repository at:
> >
> >  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge
> >
> >Mark Nelson (2):
> >      powerpc: Fix 64bit memcpy() regression
> >      powerpc: Fix 64bit __copy_tofrom_user() regression
> >
> >Michael Neuling (1):
> >      powerpc: Fix load/store float double alignment handler
> 
> You don't seem to have your fix for PCI 2.x stuff on 4xx here.  Patchwork
> has it in accepted state and Geert has been asking if it would go in 2.6.29.
> 
> Any idea what is up with that one?

This isn't a regression is it ? so it's a bit late now, have you checked
if it's in my next or test branch ? I would have though it would have
gone through your tree, maybe I missed it some way.

Ben.
