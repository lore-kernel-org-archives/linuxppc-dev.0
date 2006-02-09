Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7FF7F67A01
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Feb 2006 01:44:45 +1100 (EST)
Date: Thu, 9 Feb 2006 15:44:39 +0100
From: Olaf Hering <olh@suse.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: asm-powerpc/highmem.h missing
Message-ID: <20060209144439.GA31578@suse.de>
References: <20060208093439.GA9240@suse.de>
	<20060208211600.28252f22.sfr@canb.auug.org.au>
	<20060208124045.GA14370@suse.de>
	<335AACC0-4227-4D0F-9B4B-2B89F1368ECB@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <335AACC0-4227-4D0F-9B4B-2B89F1368ECB@kernel.crashing.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Wed, Feb 08, Kumar Gala wrote:

> You do realize there are a slew of headers in include/asm-ppc/ that  
> we use in the arch/powerpc builds for ppc32.

Yes, I just realized that I have to patch both asm/io.h files. ARGH!

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
