Return-Path: <roberto.j.guerra@gmail.com>
Received: from mail-qy0-f192.google.com (mail-qy0-f192.google.com
	[209.85.221.192]) by ozlabs.org (Postfix) with ESMTP id 7E2CAB7B70
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 13 Oct 2009 00:23:52 +1100 (EST)
Received: by qyk30 with SMTP id 30so8879975qyk.7
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 12 Oct 2009 06:23:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4AD30DF0.1000901@mta.it>
References: <4AD30DF0.1000901@mta.it>
Date: Mon, 12 Oct 2009 09:23:49 -0400
Message-ID: <7c4144600910120623k2c9aea89ia0f255164f03ff89@mail.gmail.com>
Subject: Re: Linux seamless booting
From: Roberto Guerra <roberto.j.guerra@gmail.com>
To: Fortini Matteo <matteo.fortini@mta.it>
Content-Type: text/plain; charset=ISO-8859-1
Cc: u-boot@lists.denx.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Did you try "setenv bootdelay 0" in uboot?

On Mon, Oct 12, 2009 at 7:07 AM, Fortini Matteo <matteo.fortini@mta.it> wro=
te:
> Hi all,
> we've been working on a PPC512x board booting with u-boot + linux 2.6.24.=
6,
> and one major issue for our application is boot time.
>
> Right now, we went down to less than 6s boot time (i.e. time from power o=
ff
> to launch of the user app), even with some drivers installed, i.e.:
>
> =A0 * CAN bus
> =A0 * GPU on PCI bus
> =A0 * USB host
> =A0 * UBI
>
> with r/o squashfs root and r/w ubifs configuration filesystem mounted fro=
m a
> NOR flash memory.
>
> This time could be enough for the high-level application (we're showing a
> splash screen in about 2-3s so it's ok if the main app takes a little lon=
ger
> to come up), but the whole system is connected to others via CAN and we
> can't afford the "black out" period between u-boot and linux.
>
> Some other operating systems (e.g. QNX) have this "seamless booting"
> function, in which drivers are started in stages, so that a (minimal)
> functionality can be given in milliseconds, and more functionalities come=
 up
> as time goes by.
>
> Is there a way to support something similar with the u-boot -> linux
> solution?
>
> Thank you,
> Matteo
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
