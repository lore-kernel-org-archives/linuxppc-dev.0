Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C5844B70E9
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Nov 2010 19:33:38 +1100 (EST)
Date: Tue, 16 Nov 2010 08:59:32 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Move ams driver to macintosh
Message-ID: <20101116085932.5621cc20@endymion.delvare>
In-Reply-To: <1289882005.2147.1489.camel@pasglop>
References: <20101005121043.08771994@endymion.delvare>
	<1289882005.2147.1489.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Michael Hanselmann <linux-kernel@hansmi.ch>,
	LM Sensors <lm-sensors@lm-sensors.org>,
	Stelian Pop <stelian@popies.net>, linuxppc-dev@lists.ozlabs.org,
	Guenter Roeck <guenter.roeck@ericsson.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Benjamin,

On Tue, 16 Nov 2010 15:33:25 +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2010-10-05 at 12:10 +0200, Jean Delvare wrote:
> > The ams driver isn't a hardware monitoring driver, so it shouldn't
> > live under driver/hwmon. drivers/macintosh seems much more
> > appropriate, as the driver is only useful on PowerBooks and iBooks.
> 
> Going through backlog... Do you want me to carry this in powerpc or
> you'll deal with it directly ?
> 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> > Cc: Stelian Pop <stelian@popies.net>
> > Cc: Michael Hanselmann <linux-kernel@hansmi.ch>
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

I'm glad you like this patch, as it has already been applied to Linus'
tree ;)

-- 
Jean Delvare
