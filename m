Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f220.google.com (mail-gx0-f220.google.com
	[209.85.217.220]) by ozlabs.org (Postfix) with ESMTP id 38FEDDE067
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 00:39:36 +1000 (EST)
Received: by gxk20 with SMTP id 20so7853131gxk.9
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 07:39:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090519122714.GH30753@pengutronix.de>
References: <5023288.1242734340173.JavaMail.ngmail@webmail15.arcor-online.net>
	<20090519122714.GH30753@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 19 May 2009 08:39:14 -0600
Message-ID: <fa686aa40905190739j47921320mf0d10b44d13f6dac@mail.gmail.com>
Subject: Re: Q: MTD RAM in OF Device Tree
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>,
	linux-mtd@lists.infradead.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 19, 2009 at 6:27 AM, Wolfram Sang <w.sang@pengutronix.de> wrote=
:
> Hello Albrecht,
>
> (adding linux-mtd)
>
> On Tue, May 19, 2009 at 01:59:00PM +0200, Albrecht Dre=DF wrote:
>>
>> is there a standard way to define a ram chip (in my case a battery-buffe=
red
>> nv ram, attached to the 5200's Local Bus) in the OF tree, and are there =
any
>> drivers (on 2.6.29.1) which pick up the chip/partition specification for=
 mtd?
>> Does such a driver exist, or do I have to write one (probably based on
>> plat-ram.c?)? =A0I think of something like
>
> I wrote such a driver (yet without partitioning support) and I am trying =
to get
> it mainline, just didn't get any comments so far:
>
> http://patchwork.ozlabs.org/patch/23557/
> http://patchwork.ozlabs.org/patch/23556/
>
> I'd be happy if you could give it a try and donate some
> {Acked|Tested|Reviewed}-by tags. Maybe this will help for my next try to =
get
> it mainline.

I missed them when you posted them.  I'll go look now.
--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
