Return-Path: <tpepper@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id A1243DDE21
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 08:36:15 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2218387wag
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 13:36:14 -0800 (PST)
Message-ID: <eada2a070711281336i41a7f149i2c1db7cd49c0fd69@mail.gmail.com>
Date: Wed, 28 Nov 2007 13:36:13 -0800
From: "Tim Pepper" <tpepper@gmail.com>
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: Why are CONFIG_LOCKDEP_SUPPORT, CONFIG_TRACE_IRQFLAGS_SUPPORT,
	and CONFIG_STACKTRACE_SUPPORT not defined for PowerPC?
In-Reply-To: <474DC7D0.4080907@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <474DC7D0.4080907@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Nov 28, 2007 11:56 AM, Timur Tabi <timur@freescale.com> wrote:
> These three Kconfig options:
>
>         CONFIG_LOCKDEP_SUPPORT
>         CONFIG_TRACE_IRQFLAGS_SUPPORT
>         CONFIG_STACKTRACE_SUPPORT
>
> Are not defined for ppc or powerpc, but they are defined for several other
> architectures.  I'm trying to debug some semaphore locks in ALSA, and these
> defines are necessary to enable some other Kconfig features.

These work for me, but I don't think they're finalised yet so your
mileage may vary:

http://patchwork.ozlabs.org/linuxppc/patch?id=14171
http://patchwork.ozlabs.org/linuxppc/patch?id=14172



Tim
