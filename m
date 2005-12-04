Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 355A268847
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Dec 2005 11:12:07 +1100 (EST)
Date: Sat, 3 Dec 2005 16:12:05 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <20051204001205.GA20763@gate.ebshome.net>
References: <11336368261610-git-send-email-otavio@debian.org>
	<20051203212402.GA2821@gate.ebshome.net>
	<20051203160020.42d1da3c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051203160020.42d1da3c.akpm@osdl.org>
Cc: linuxppc-dev@ozlabs.org, otavio@debian.org
Subject: Re: [PATCH] include/asm-ppc/btext.h: add prototype of btext_init
	function.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Dec 03, 2005 at 04:00:20PM -0800, Andrew Morton wrote:
> Eugene Surovegin <ebs@ebshome.net> wrote:
> >
> >  > +extern void __init btext_init(boot_infos_t *bi);
> >  >  extern void btext_welcome(void);
> >  >  extern void btext_prepare_BAT(void);
> >  >  extern void btext_setup_display(int width, int height, int depth, int pitch,
> > 
> >  "__init" should be placed between closing brace and semicolon. For 
> >  more info, see include/linux/init.h
> 
> I don't think it matters much.  Often we just omit it from the declaration
> - it's only required at the definition site

Quite likely it doesn't matter, but I think we should follow existing 
style, if not for correctness, but at least for consistency (it 
actually caught my eye exactly because it _looked_ different). I'm 
pretty sure original poster have tested original version :).

-- 
Eugene
