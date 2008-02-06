Return-Path: <jwboyer@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.225])
	by ozlabs.org (Postfix) with ESMTP id 63E93DDF27
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 03:24:05 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so2787578wxd.15
	for <linuxppc-dev@ozlabs.org>; Wed, 06 Feb 2008 08:24:03 -0800 (PST)
Date: Wed, 6 Feb 2008 10:23:40 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] net: NEWEMAC: Remove "rgmii-interface" from rgmii
	matching table
Message-ID: <20080206102340.1cdf7f8d@zod.rchland.ibm.com>
In-Reply-To: <20080206160157.GA18228@lixom.net>
References: <1202300519-7294-1-git-send-email-sr@denx.de>
	<20080206160157.GA18228@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>, jeff@garzik.org,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 6 Feb 2008 10:01:57 -0600
Olof Johansson <olof@lixom.net> wrote:

> On Wed, Feb 06, 2008 at 01:21:59PM +0100, Stefan Roese wrote:
> > With the removal the the "rgmii-interface" device_type property from the
> > dts files, the newemac driver needs an update to only rely on compatible
> > property.
> 
> What about systems using an older dts, such as one kexec:ing from an
> older kernel?

Like what?  Kexec doesn't work on 4xx yet.

> Just because the device tree source is distributed in the kernel tree
> doesn't mean it can give up backwards compatibility.

We checked Axon, which is the only non-DTS machine that uses EMAC and
it will work fine with this change.

josh
