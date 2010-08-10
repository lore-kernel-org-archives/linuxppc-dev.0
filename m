Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f170.google.com (mail-gx0-f170.google.com
	[209.85.161.170]) by ozlabs.org (Postfix) with ESMTP id 99DCAB70AF
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Aug 2010 17:16:31 +1000 (EST)
Received: by gxk25 with SMTP id 25so6491116gxk.15
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Aug 2010 00:16:30 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <796604.30863.qm@web180307.mail.gq1.yahoo.com>
References: <AANLkTik9cy+at2n28U+Mut4RD6_cJ9uRZzjf+H86d-rp@mail.gmail.com>
	<796604.30863.qm@web180307.mail.gq1.yahoo.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 10 Aug 2010 01:16:10 -0600
Message-ID: <AANLkTi=FGf9gbWDkO4qs01Z+qkip+Zm11=Jc4wHu3G8b@mail.gmail.com>
Subject: Re: [spi-devel-general] [PATCH v2 3/6] mtd: m25p80: add support to
	parse the SPI flash's partitions
To: David Brownell <david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Mingkai Hu <Mingkai.hu@freescale.com>,
	kumar.gala@freescale.com, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 10, 2010 at 1:14 AM, David Brownell <david-b@pacbell.net> wrote=
:
>
>
> --- On Mon, 8/9/10, Grant Likely <grant.likely@secretlab.ca> wrote:
>
>
>> > + =A0 =A0 =A0 nr_parts =3D
>> of_mtd_parse_partitions(&spi->dev, np, &parts);
>
> Let's keep OF-specific logic out of drivers like
> this one ... =A0intended to work without OF.
>
> NAK on adding dependencies like OF to drivers
> and other infrastructure that starts generic.

The OF hooks compile to no-ops when CONFIG_OF is disabled.  I've been
very careful about that.

g.
