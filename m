Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 5FD92DE0C2
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 15:17:42 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: benh@kernel.crashing.org
Subject: Re: [PATCH v2] [POWERPC] 4xx: Add endpoint support to 4xx PCIe driver
Date: Tue, 22 Apr 2008 07:17:30 +0200
References: <1208789670-28909-1-git-send-email-sr@denx.de>
	<1208812591.9640.45.camel@pasglop>
In-Reply-To: <1208812591.9640.45.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200804220717.30546.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 21 April 2008, Benjamin Herrenschmidt wrote:
> On Mon, 2008-04-21 at 16:54 +0200, Stefan Roese wrote:
> > --------------
> > - As suggested by Benjamin Herrenschmidt, don't determine endpoint mode
> >   by looking at the already configured PCIe port state, but evaluate
> >   the device_type property instead. This makes it possible for boards
> >   without a previously run PCIe configuration (e.g. U-Boot) to configure
> >   a port as endpoint as well.
> >
> > - Don't map the big external config space upon endpoint configuration.
> >
> > - Introduce "vendor-id" and "device-id" properties to be written to
> >   the host bridge.
>
> and class-code too ?

Sure, could be done. But this is not really endpoint/root-complex related. So 
I suggest to add this later with an additional patch.

> Appart from that, I'll have a quick look at the patch later today but at
> first it looks good.

Thanks.

Best regards,
Stefan
