Return-Path: <diggskevin38@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BC3BC1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Jan 2011 14:59:08 +1100 (EST)
Received: by iye19 with SMTP id 19so1183928iye.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Jan 2011 19:59:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1296078183.2349.141.camel@pasglop>
References: <AANLkTikJ8V-gQv93HBDH3=4o51vY5xyxQojqEV7DqNj=@mail.gmail.com>
	<1296016338.2349.125.camel@pasglop>
	<AANLkTim7gDwj+xCxiiTka23eu=v7kZX+Pq=3sQ1FT49J@mail.gmail.com>
	<1296078183.2349.141.camel@pasglop>
Date: Wed, 26 Jan 2011 21:59:05 -0600
Message-ID: <AANLkTinS8wJq-wr1=yoeC-f-FcToPzsKLmA3hrshaUms@mail.gmail.com>
Subject: Re: 750gx cpufreq induced kernel panic in 2.6.36
From: kevin diggs <diggskevin38@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 26, 2011 at 3:43 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> You don't have a serial port ?
>
Yeah, just did not know what to do with them?

> If you do, use "sccdbg" on the kernel command line to route xmon to it,
> and boot with console=ttyPZ0,38400 (I think the old things default to
> 38400 bauds). Use the "modem" port.
>
Ok! Thanks!

One thing. The 2.6 driver for the serial ports on this machine does
not work very well. Can I use a slower speed to avoid missing stuff?

And I'll need to build the serial stuff into the kernel, right?

Thanks for the reply!

> Cheers,
> Ben.
>
