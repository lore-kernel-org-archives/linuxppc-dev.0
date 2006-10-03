Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AF05A67BAC
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Oct 2006 21:52:57 +1000 (EST)
Subject: Re: Undefined '.bus_to_virt', '.virt_to_bus' causes compile error
	on Powerpc 64-bit
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1159837539.5482.15.camel@localhost.localdomain>
References: <20061002214954.GD665@shell0.pdx.osdl.net>
	<1159837539.5482.15.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 12:23:16 +0100
Message-Id: <1159874596.17553.11.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Judith Lebzelter <judith@osdl.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ar Maw, 2006-10-03 am 11:05 +1000, ysgrifennodd Benjamin Herrenschmidt:
> On Mon, 2006-10-02 at 14:49 -0700, Judith Lebzelter wrote:
> > Hello:
> > 
> > For the automated cross-compile builds at OSDL, powerpc 64-bit 
> > 'allmodconfig' is failing.  The warnings/errors below appear in 
> > the 'modpost' stage of kernel compiles for 2.6.18 and -mm2 kernels.
> 
> All those drivers are bogus and need to be updated. They should be
> marked CONFIG_BROKEN

Several of them are only really meaningful on PC so marking them BROKEN
is the wrong answer. Some of them definitely do need updating but stuff
like the remaining OSS drivers are just waiting to die out quietly.
