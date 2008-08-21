Return-Path: <super.firetwister@googlemail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id 1F159DDF18
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 22:53:35 +1000 (EST)
Received: by gxk14 with SMTP id 14so547684gxk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 05:53:34 -0700 (PDT)
Message-ID: <6a6049b80808210546k51728cd2mf47c73487fe5033f@mail.gmail.com>
Date: Thu, 21 Aug 2008 14:46:32 +0200
From: "M B" <super.firetwister@googlemail.com>
To: jwboyer@linux.vnet.ibm.com
Subject: Re: [PATCH] add a simple 405EP based board
In-Reply-To: <1219319729.26429.40.camel@jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200808211007.59965.super.firetwister@gmail.com>
	<1219319729.26429.40.camel@jdub.homelinux.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 8/21/08, Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> I plan on adding more 405 board support very soon.  When I do, it'll be
> along the lines of the patch series I just sent out for 44x.  There's
> really no reason to have a per CPU/board file if we can avoid it.
>
> Your code is simple enough overall, so I might even use it as a starting

>

I've seen your patches for 44x support and I like the idea of a
general board setup.
I wanted to make the dts public, because I needed some help to figure
out the "mdio-device" tag. So if you have further use for this you're
welcome.

> Though it's incomplete
> in that you have a DTS that requires something to poke values into it,
> and nothing readily apparent to do so.  A cuImage wrapper is probably
> warranted here.

The missing values in the dts get filled in by ft_cpu_setup(...) from
uboot, it's generic code and not board specific, but the board setup
in u-boot must call it, so it won't work for all boards.

Best regards

Markus
