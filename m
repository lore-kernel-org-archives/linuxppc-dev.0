Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6875B6884E
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Dec 2005 09:23:11 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Redondo Garcia, Roberto" <rredondo@indra.es>
In-Reply-To: <6A28467355D2AD478D1F51C479415AE77B47E9@MADTORMAIL.indra.es>
References: <6A28467355D2AD478D1F51C479415AE77B47E9@MADTORMAIL.indra.es>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 09:16:02 +1100
Message-Id: <1133734562.6100.104.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: back trace when a SIGSEGV
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2005-12-02 at 11:33 +0100, Redondo Garcia, Roberto wrote:
> hello, 
> I have a program that when it has been several hours running, it has a
> problem and falls and it produces a SIGSEGV.  I would like to know to
> how debug this error, because I do not have ulimit for generate core
> dump o examine a back trace.

You can run your program under gdb, or you may want to have a look at
tridge' junk code directory for his segv_handler bit that you can put in
LD_PRELOAD

http://www.samba.org/junkcode/#segv_handler

Ben.
