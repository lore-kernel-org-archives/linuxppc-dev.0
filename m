Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8080E67A42
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 03:58:48 +1000 (EST)
Date: Mon, 29 May 2006 19:58:34 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] powerpc: add dmesg command to xmon
Message-ID: <20060529175834.GA31082@suse.de>
References: <20060528104621.GA7126@suse.de> <200605281404.26070.arnd@arndb.de>
	<20060528120748.GA7608@suse.de> <200605281812.09308.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200605281812.09308.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Sun, May 28, Arnd Bergmann wrote:

> On Sunday 28 May 2006 14:07, Olaf Hering wrote:
> > > This whole function looks fishy to me. It seems unnecessarily rude to me to
> > > use kallsyms_lookup_name in order to get at a static variable from another
> > > file. Can't you instead add a global function to kernel/printk.c to return
> > > the buffer?
> > 
> > Its possible, but it wont end up in Linus tree.
> 
> Hmm, so the idea is that because Linus doesn't like kernel debuggers, we just
> obfuscate the code for any improvements to xmon and hope he doesn't notice?

So lets just ask again for support in generic code for a dmesg command in xmon:

http://lkml.org/lkml/2004/10/28/32

vs. these 2 patches

http://ozlabs.org/pipermail/linuxppc-dev/2006-May/023261.html
http://lkml.org/lkml/2006/5/29/55

or no dmesg at all.
