Return-Path: <James.Bottomley@HansenPartnership.com>
Received: from accolon.hansenpartnership.com (accolon.hansenpartnership.com
	[76.243.235.52]) by ozlabs.org (Postfix) with ESMTP id 99C48DDF64
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 10:11:45 +1000 (EST)
Subject: Re: [PATCH] fix compile failure with non modular builds
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: benh@kernel.crashing.org
In-Reply-To: <1221005387.14835.14.camel@pasglop>
References: <1221005058.23271.16.camel@localhost.localdomain>
	<1221005387.14835.14.camel@pasglop>
Content-Type: text/plain
Date: Tue, 09 Sep 2008 19:11:45 -0500
Message-Id: <1221005505.23271.18.camel@localhost.localdomain>
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

On Wed, 2008-09-10 at 10:09 +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2008-09-09 at 19:04 -0500, James Bottomley wrote:
> > commit deac93df26b20cf8438339b5935b5f5643bc30c9
> > Author: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Date:   Wed Sep 3 20:43:36 2008 -0500
> > 
> >     lib: Correct printk %pF to work on all architectures
> > 
> > Broke the non modular builds by moving an essential function into
> > modules.c.  Fix this by moving it out again and into asm/sections.h as
> > an inline.  To do this, the definition of struct ppc64_opd_entry has
> > been lifted out of modules.c and put in asm/elf.h where it belongs.
> > 
> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> 
> Ouch. Ack.

Actually, this is for your powerpc tree, so we actually run it through
some extended config testing this time ...

James
