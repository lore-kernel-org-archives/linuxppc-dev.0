Return-Path: <olh@suse.de>
Received: from Cantor.suse.de (news.suse.de [195.135.220.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2C67467A84
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Feb 2005 04:25:56 +1100 (EST)
Date: Sun, 6 Feb 2005 18:25:52 +0100
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20050206172552.GC19327@suse.de>
References: <20050206125056.GA6394@suse.de>
	<20050206165428.GA7686@smtp.west.cox.net>
	<20050206165629.GA18769@suse.de>
	<20050206172431.GB7686@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20050206172431.GB7686@smtp.west.cox.net>
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

> My first guess then is there's a dependancy problem, as make tags should
> just invoke ctags or so, yes?

The variable is evaluated, even if it is not used.
Just run 'make ARCH=ppc tags' and see yourself.
