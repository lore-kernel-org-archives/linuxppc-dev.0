Return-Path: <adrian@rhlx01.hs-esslingen.de>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "rhlx01.hs-esslingen.de", Issuer "HE CA - G02" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2D69CB7D18
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 25 May 2010 18:48:30 +1000 (EST)
Date: Tue, 25 May 2010 10:41:56 +0200
From: Adrian Reber <adrian@lisas.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: mmio_nvram.c users ?
Message-ID: <20100525084156.GB24606@lisas.de>
References: <1274773439.1931.238.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1274773439.1931.238.camel@pasglop>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 25, 2010 at 05:43:59PM +1000, Benjamin Herrenschmidt wrote:
> Anybody aware of anything other than Cell using that driver ?
> 
> I'd like to make it a platform driver instead of having something that
> pokes at anything that has a "device_type" set to "nvram" (which is
> gross and bogus). But I need to know what platforms to fixup...

The PowerStation is also using it.

		Adrian
