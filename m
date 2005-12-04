Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 742666884B
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Dec 2005 11:00:36 +1100 (EST)
Date: Sat, 3 Dec 2005 16:00:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eugene Surovegin <ebs@ebshome.net>
Message-Id: <20051203160020.42d1da3c.akpm@osdl.org>
In-Reply-To: <20051203212402.GA2821@gate.ebshome.net>
References: <11336368261610-git-send-email-otavio@debian.org>
	<20051203212402.GA2821@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Eugene Surovegin <ebs@ebshome.net> wrote:
>
>  > +extern void __init btext_init(boot_infos_t *bi);
>  >  extern void btext_welcome(void);
>  >  extern void btext_prepare_BAT(void);
>  >  extern void btext_setup_display(int width, int height, int depth, int pitch,
> 
>  "__init" should be placed between closing brace and semicolon. For 
>  more info, see include/linux/init.h

I don't think it matters much.  Often we just omit it from the declaration
- it's only required at the definition site
