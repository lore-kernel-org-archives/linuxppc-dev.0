Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 991AA67E06
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Aug 2005 09:05:41 +1000 (EST)
Date: Tue, 2 Aug 2005 16:05:37 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Jon Loeliger <jdl@freescale.com>
Message-ID: <20050802230537.GA9125@gate.ebshome.net>
References: <1123023575.2614.25.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1123023575.2614.25.camel@cashmere.sps.mot.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: Beginning Merger Patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 02, 2005 at 05:59:35PM -0500, Jon Loeliger wrote:
> Here is a patch to begin the process of merging
> the PPC32 and PPC64 include directories into a
> new common "powerpc" arch.
> 
> This patch introduces the include/asm-powerpc directory.
> It then places into it, all of the files in asm-ppc and
> asm-ppc64 that are essentially identical.  A stub is left
> in asm-ppc and asm-ppc64 pointing to the unified files.
> No real thought went into this set of files; these are
> the dead-simple identical files for starters!

Hmm, I got an impression that we wouldn't touch ppc and ppc64 for 
now and just _copy_ or create clean stuff into powerpc. I think this 
will be much safer, at least at the beginning.

-- 
Eugene
