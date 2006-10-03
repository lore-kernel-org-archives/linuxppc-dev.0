Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C1B0867BF7
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Oct 2006 21:05:24 +1000 (EST)
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1159850260.5482.34.camel@localhost.localdomain>
References: <20061002214954.GD665@shell0.pdx.osdl.net>
	<20061002234428.GE3278@stusta.de>  <20061003012241.GF3278@stusta.de>
	<1159840091.2349.0.camel@entropy>
	<1159850260.5482.34.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 12:29:35 +0100
Message-Id: <1159874975.17553.17.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Nicholas Miell <nmiell@comcast.net>,
	Judith Lebzelter <judith@osdl.org>, linux-kernel@vger.kernel.org,
	Adrian Bunk <bunk@stusta.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ar Maw, 2006-10-03 am 14:37 +1000, ysgrifennodd Benjamin Herrenschmidt:
> > Won't this also cause warnings for valid arch-specific usage (i.e. in
> > linux/arch/{i386,x86_64})?
> 
> I wouldn't cause that usage valid :)

Actually a lot of the older legitimate users (DRM/AGP) have been cleaned
up so it might be worth doing now after all.

Ok I take back the NAK having looked deeper. We appear to have made
sufficient progress along the way.

Acked-by: Alan Cox <alan@redhat.com>
