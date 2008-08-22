Return-Path: <jonsmirl@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id 831BADDE04
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 12:39:45 +1000 (EST)
Received: by gxk14 with SMTP id 14so897873gxk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 19:39:40 -0700 (PDT)
Message-ID: <9e4733910808211939s24f1b2f0tc470aaf3831ebcca@mail.gmail.com>
Date: Thu, 21 Aug 2008 22:39:40 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
In-Reply-To: <fa686aa40808211933o72c2da60v557d5a58f2c9d1a7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080821.001012.265401427.davem@davemloft.net>
	<20080821163256.GC15669@ld0162-tx32.am.freescale.net>
	<20080821.142134.127315039.davem@davemloft.net>
	<48ADDF86.2040200@freescale.com>
	<fa686aa40808211614q72f6719btd391830abded58f6@mail.gmail.com>
	<9e4733910808211645p27ff2c6ci6dba6f363e9ece15@mail.gmail.com>
	<fa686aa40808211933o72c2da60v557d5a58f2c9d1a7@mail.gmail.com>
Cc: devicetree-discuss@ozlabs.org, linuxppc-dev@ozlabs.org,
	sparclinux@vger.kernel.org, paulus@samba.org,
	Scott Wood <scottwood@freescale.com>, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 8/21/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Thu, Aug 21, 2008 at 5:45 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>  > On 8/21/08, Grant Likely <grant.likely@secretlab.ca> wrote:
>
> >> Ugh, more like loads of pain.  There are deployed platforms using the
>  >>  embedded 'invented' bindings.  I don't think it is an option to break
>  >>  compatibility with older trees.  If there is some backwards
>  >>  compatibility code then I'm all for migrating to the same binding as
>  >>  Sparc and PowerMac
>  >
>  > Has anything really been deployed? These bindings are only a few months old.
>
>
> It was over a year ago when support for i2c devices in the device tree
>  was merged.

I see, the old support needed the drivers to be built-in. The newer
code dynamically loads the correct i2c driver and set its parameters.

Did the old code use anything besides compatible? It would have been
using the older i2c system that probed for the address.

>
>  See commit id d13ae8620dfdedfa7e9ab6d1eec294adc0516065.
>
>
>  g.
>
>  --
>  Grant Likely, B.Sc., P.Eng.
>  Secret Lab Technologies Ltd.
>


-- 
Jon Smirl
jonsmirl@gmail.com
