Return-Path: <timur.tabi@gmail.com>
Received: from mail-px0-f170.google.com (mail-px0-f170.google.com
	[209.85.212.170]) by ozlabs.org (Postfix) with ESMTP id 9D08BB7D11
	for <linuxppc-dev@ozlabs.org>; Thu, 20 May 2010 11:46:50 +1000 (EST)
Received: by pxi6 with SMTP id 6so1213311pxi.15
	for <linuxppc-dev@ozlabs.org>; Wed, 19 May 2010 18:46:49 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <20100520011820.GT25892@yookeroo>
References: <1274298809-12772-1-git-send-email-timur@freescale.com>
	<1274304013.1931.6.camel@pasglop> <4BF4593E.8030101@freescale.com>
	<1274309050.1931.21.camel@pasglop>
	<AANLkTilefxXcMnWqKSultu88r4D9W98adHLHxvUwi113@mail.gmail.com>
	<20100520011820.GT25892@yookeroo>
From: Timur Tabi <timur@freescale.com>
Date: Wed, 19 May 2010 20:46:19 -0500
Message-ID: <AANLkTily6AYGJbvTx-4MJm7HKeRWOuB9jpPzgVmys1sm@mail.gmail.com>
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

On Wed, May 19, 2010 at 8:18 PM, David Gibson
<david@gibson.dropbear.id.au> wrote:

> Couldn't you use the configurable padding, but put the stuff to do it
> into u-boot. =A0i.e. repad the dtb at u-boot build time, rather than
> u-boot runtime.

That's what I was trying to do.   Take a look at this thread:

http://lists.denx.de/pipermail/u-boot/2010-May/071520.html

--=20
Timur Tabi
Linux kernel developer at Freescale
