Return-Path: <olh@suse.de>
Received: from Cantor.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id DF44F67A6D
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Feb 2005 07:08:09 +1100 (EST)
Date: Sun, 6 Feb 2005 21:08:02 +0100
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20050206200802.GA28652@suse.de>
References: <20050206125056.GA6394@suse.de>
	<20050206165428.GA7686@smtp.west.cox.net>
	<20050206165629.GA18769@suse.de>
	<20050206172431.GB7686@smtp.west.cox.net>
	<20050206172552.GC19327@suse.de>
	<20050206200431.GC7686@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20050206200431.GC7686@smtp.west.cox.net>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] remove .tmp_gas_check
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Sun, Feb 06, Tom Rini wrote:

> Right.  But we only care about that if we're going to compile anything,
> so perhaps we need to change the test somehow to only get evaluated when
> needed (ala the -mcpu stuff?  Or is that always run as well?).

I dont want to see that file because its just a tmpfile.
mkdir $foo
make ARCH=ppc tags &
make ARCH=ppc O=$foo -j menuconfig 
make ARCH=ppc O=$foo -j all

Its just in the way when doing diffs. and make clean may remove the tags
file. But its just silly to expect 'make tags; make clean' to get rid of it.
