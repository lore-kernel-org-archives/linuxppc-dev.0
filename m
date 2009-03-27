Return-Path: <timur.tabi@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id B1991DDED9
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Mar 2009 09:07:54 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so747490yxg.39
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2009 15:07:52 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <17008330.1238159104446.JavaMail.ngmail@webmail11.arcor-online.net>
References: <17008330.1238159104446.JavaMail.ngmail@webmail11.arcor-online.net>
Date: Fri, 27 Mar 2009 17:07:52 -0500
Message-ID: <ed82fe3e0903271507x6e73e93er8e4899250bf09ff8@mail.gmail.com>
Subject: Re: Q: define i2c nodes in device tree?
From: Timur Tabi <timur@freescale.com>
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 27, 2009 at 8:05 AM, Albrecht Dre=DF <albrecht.dress@arcor.de> =
wrote:

> Now the driver is called, but complains that no platform data is present.=
 =A0Still have to figure out how to pass that... :-/

I believe there was code added recently to i2c-mpc.c to put DTS
properties into the platform device, but I don't see it right now.

> # ls -al /sys/devices/f0000000.soc5200/f0003d40.i2c/i2c-adapter/i2c-1/
> drwxr-xr-x =A0 =A06 0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 Jan =
=A01 00:00 .
> drwxr-xr-x =A0 =A03 0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 Jan =
=A01 00:00 ..
> drwxr-xr-x =A0 =A02 0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 Jan =
=A01 00:00 1-0020
> drwxr-xr-x =A0 =A02 0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 Jan =
=A01 00:00 1-0021
> drwxr-xr-x =A0 =A02 0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 Jan =
=A01 00:00 1-0022
> [...]
>
> Is this the intended behaviour?

I think the entries in /sys/devices/f0000000.soc5200 are from the
device tree directly.  They're not related to any device driver.  I
believe you'll find those entries still there even if your driver
isn't loaded at all.

--=20
Timur Tabi
Linux kernel developer at Freescale
