Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F040A67C1C
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jul 2005 03:30:01 +1000 (EST)
Date: Sun, 3 Jul 2005 19:29:55 +0200
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20050703172955.GA25976@suse.de>
References: <17016.29775.224816.691409@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <17016.29775.224816.691409@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, trini@kernel.crashing.org
Subject: Re: [PATCH] Set cpu explicitly in kernel compiles
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Wed, May 04, Paul Mackeras wrote:

> What do people think of this patch?  The motivation for it is that a
> biarch gcc-4.0 will by default tune for POWER4, even for a 32-bit
> compile, meaning that we end up with a lot of nops we don't need.
> This also takes out -mstring.
> 
> With this, the text size reduces by about 120k for my normal config
> when compiling with a biarch gcc-4.0.  The text size also reduces
> slightly when compiling with the Debian gcc-3.3.5 (32-bit only, not
> biarch).
> 
> If there are no objections I'll send this to Andrew and Linus.

What will be done about this patch? -mcpu=750 reduces .text by 70k.


   text    data     bss     dec     hex filename
3397801  579544  519704 4497049  449e99 ../O-ppc-cpu601/vmlinux
3397502  579544  519704 4496750  449d6e ../O-ppc-cpu604/vmlinux
3397953  579544  519704 4497201  449f31 ../O-ppc-cpu750/vmlinux
3469857  579544  519704 4569105  45b811 ../O-ppc-default/vmlinux
