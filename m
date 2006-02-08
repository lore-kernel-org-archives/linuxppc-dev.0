Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9209468A99
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Feb 2006 21:51:20 +1100 (EST)
Date: Wed, 8 Feb 2006 11:51:14 +0100
From: Olaf Hering <olh@suse.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: asm-powerpc/highmem.h missing
Message-ID: <20060208105114.GA11847@suse.de>
References: <20060208093439.GA9240@suse.de>
	<20060208211600.28252f22.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060208211600.28252f22.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Wed, Feb 08, Stephen Rothwell wrote:

> On Wed, 8 Feb 2006 10:34:39 +0100 Olaf Hering <olh@suse.de> wrote:
> >
> > 
> > Why was asm-ppc/highmem.h not migrated? linux/highmem.h and pagemap.h wants it.
> 
> I guess it was not migrated because it is only required for CONFIG_HIGHMEM
> and, of course, ppc64 does not need HIGHMEM and presumably noone has tried
> to build with CONFIG_HIGHMEM set in ARCH=powerpc until now.

Well, thats not really true, ppc32 builds/works just fine with that, if you
want to use more than 768MB.
The quickcam kernel module did include pagemap.h, but it works just fine
without it. So nothing needs to be changed in the kernel.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
