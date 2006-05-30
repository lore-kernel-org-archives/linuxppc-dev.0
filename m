Return-Path: <linas@austin.ibm.com>
Received: from over.co.us.ibm.com (over.co.us.ibm.com [32.97.110.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1AE5267B2B
	for <linuxppc-dev@ozlabs.org>; Wed, 31 May 2006 07:04:55 +1000 (EST)
Received: from e4.ny.us.ibm.com (e4.pok.ibm.com [9.56.232.144])
	by bldfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k4UGwRio030815
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 12:58:28 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k4UGwLpq015194
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 12:58:21 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k4UGwKHG088548
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 12:58:20 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k4UGwKmH003887
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 12:58:20 -0400
Date: Tue, 30 May 2006 11:58:19 -0500
To: Olaf Hering <olh@suse.de>
Subject: Re: [PATCH] powerpc: add dmesg command to xmon
Message-ID: <20060530165819.GB7021@austin.ibm.com>
References: <20060528104621.GA7126@suse.de> <200605281404.26070.arnd@arndb.de>
	<20060528120748.GA7608@suse.de> <200605281812.09308.arnd@arndb.de>
	<20060529175834.GA31082@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060529175834.GA31082@suse.de>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Linus Torvalds <torvalds@osdl.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 29, 2006 at 07:58:34PM +0200, Olaf Hering wrote:
>  On Sun, May 28, Arnd Bergmann wrote:
> 
> > On Sunday 28 May 2006 14:07, Olaf Hering wrote:
> > > > This whole function looks fishy to me. It seems unnecessarily rude to me to
> > > > use kallsyms_lookup_name in order to get at a static variable from another
> > > > file. Can't you instead add a global function to kernel/printk.c to return
> > > > the buffer?
> > > 
> > > Its possible, but it wont end up in Linus tree.
> > 
> > Hmm, so the idea is that because Linus doesn't like kernel debuggers, we just
> > obfuscate the code for any improvements to xmon and hope he doesn't notice?
> 
> So lets just ask again for support in generic code for a dmesg command in xmon:
> 
> http://lkml.org/lkml/2004/10/28/32

I'd been planning to pester Torvalds/LKML on a regular basis until the
patch (or something else suitable) went in. Clearly, I'd failed to do
this. 

--linas

p.s. Belated apologies for failing to mention KDB; I assumed it would be 
"obvious" to those who know, and that by not mentioning KDB explicitly, 
I thought that the patch would have a better chance of acceptance (which
I expected to be low). Silly me. 
