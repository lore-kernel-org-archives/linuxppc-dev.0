Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 474E8DE068
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Feb 2007 03:00:59 +1100 (EST)
In-Reply-To: <1172505207.11949.15.camel@localhost.localdomain>
References: <200612112059.kBBKx1j7022473@hera.kernel.org>
	<1172448057.3971.9.camel@shinybook.infradead.org>
	<Pine.LNX.4.64.0702251614420.12485@woody.linux-foundation.org>
	<1172452660.3971.33.camel@shinybook.infradead.org>
	<Pine.LNX.4.64.0702251940500.12485@woody.linux-foundation.org>
	<1172462466.3971.46.camel@shinybook.infradead.org>
	<1172505207.11949.15.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f42ffce99aed41ad91cb96c10e67d908@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Make sure we populate the initroot filesystem late enough
Date: Mon, 26 Feb 2007 17:00:49 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: john stultz <johnstul@us.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> And check that we didn't end up stupidly having the initrd share a page
> with something else ... (like not aligned end or such thingy).

David tested that yesterday, it's not the case.  Too bad,
would have been too easy ;-)


Segher
