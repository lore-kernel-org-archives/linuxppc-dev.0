Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 13A77679E9
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 22:20:13 +1000 (EST)
Subject: Re: [PATCH] powerpc: Fix windfarm platform device usage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
In-Reply-To: <20061010120923.GA1516@curie-int.orbis-terrarum.net>
References: <1160444851.32237.41.camel@localhost.localdomain>
	<20061010120923.GA1516@curie-int.orbis-terrarum.net>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 22:19:51 +1000
Message-Id: <1160482792.6177.12.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-10-10 at 05:09 -0700, Robin H. Johnson wrote:
> On Tue, Oct 10, 2006 at 11:47:31AM +1000, Benjamin Herrenschmidt wrote:
> > The windfarm code uses a struct device_driver instead of
> > platform_driver, which can cause crashes if any of the callbacks are
> > called (like on module removal). This fixes it.
> Thanks! This makes my windfarm work a lot easier!
> (I am still working on it, just very slowly).

Ah good news :)

Ben.
