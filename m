Return-Path: <colin@colino.net>
Received: from paperstreet.colino.net (colino.net [213.41.131.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6971F679F7
	for <linuxppc-dev@ozlabs.org>; Tue,  3 May 2005 18:37:45 +1000 (EST)
Date: Tue, 3 May 2005 08:37:28 +0200
From: Colin Leroy <colin@colino.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050503083728.3bedc3ef@colin.toulouse>
In-Reply-To: <1115072133.6031.33.camel@gaston>
References: <1115072133.6031.33.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	DebianPPC <debian-powerpc@lists.debian.org>
Subject: Re: Laptop sleep & current "git" tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 03 May 2005 08:15:33 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

Hi Ben,

> All my pending patches regarding power management are now upstream in
> Linus "git" repository. That means I expect those to fix all known
> issues (with the notable exception of the USB related problems, all of
> these things aren't yet there but they aren't under my control, so
> still unplug USB devices).

All the USB patches from David Brownell that I tracked are in
git too, including the ehci repower stuff I sent him. I don't have
issues with these patches applied. Do you?

-- 
Colin
