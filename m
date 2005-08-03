Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C2BD467E33
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Aug 2005 12:58:09 +1000 (EST)
Date: Tue, 2 Aug 2005 19:58:06 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Nathan Lynch <ntl@pobox.com>
Message-ID: <20050803025806.GC9125@gate.ebshome.net>
References: <1123023575.2614.25.camel@cashmere.sps.mot.com>
	<20050803021742.GB3985@otto>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050803021742.GB3985@otto>
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

On Tue, Aug 02, 2005 at 09:17:42PM -0500, Nathan Lynch wrote:
> Jon Loeliger wrote:
> > Folks,
> > 
> > I have grabbed my asbestos suit.
> > 
> > Here is a patch to begin the process of merging
> > the PPC32 and PPC64 include directories into a
> > new common "powerpc" arch.
> 
> Perhaps you could briefly explain the motivation for this?
> 
> I think I've heard/read that something like this was in the works, but
> I'd like to know what the problem is, and why it should be solved this
> way instead of e.g. x86_64's method of including headers directly from
> asm-i386.

I think the reason for such approach is that there will be no asm-ppc 
and asm-ppc64 in the end of this transition. This differs 
significantly from i386/x86_64 situation.

-- 
Eugene
