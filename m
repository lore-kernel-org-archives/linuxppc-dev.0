Return-Path: <timur.tabi@gmail.com>
Received: from mail-pw0-f42.google.com (mail-pw0-f42.google.com
	[209.85.160.42]) by ozlabs.org (Postfix) with ESMTP id 9D048B7D2D
	for <linuxppc-dev@ozlabs.org>; Thu, 20 May 2010 21:41:21 +1000 (EST)
Received: by pwi6 with SMTP id 6so541489pwi.15
	for <linuxppc-dev@ozlabs.org>; Thu, 20 May 2010 04:41:20 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <20100520061739.GE25892@yookeroo>
References: <1274298809-12772-1-git-send-email-timur@freescale.com>
	<1274304013.1931.6.camel@pasglop> <4BF4593E.8030101@freescale.com>
	<1274309050.1931.21.camel@pasglop>
	<AANLkTilefxXcMnWqKSultu88r4D9W98adHLHxvUwi113@mail.gmail.com>
	<20100520011820.GT25892@yookeroo>
	<AANLkTily6AYGJbvTx-4MJm7HKeRWOuB9jpPzgVmys1sm@mail.gmail.com>
	<20100520061739.GE25892@yookeroo>
From: Timur Tabi <timur@freescale.com>
Date: Thu, 20 May 2010 06:40:50 -0500
Message-ID: <AANLkTineV8MVuQGsIa81LOkO6BkJP9iU7MAX7OEz1lcu@mail.gmail.com>
Subject: Re: [PATCH] powerpc: make the padding for the device tree a
	configurable option
To: Timur Tabi <timur@freescale.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 20, 2010 at 1:17 AM, David Gibson
<david@gibson.dropbear.id.au> wrote:

> Um.. what? =A0As far as I can tell that thread is about runtime
> expanding the space given to the dtb. =A0I'm talking about altering the
> padding on the file before giving it to u-boot in the first place.

Sorry, I guess I don't understand.  How do I alter the padding before
giving it to U-Boot?

--=20
Timur Tabi
Linux kernel developer at Freescale
