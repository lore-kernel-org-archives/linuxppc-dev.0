Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D262BB707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 07:44:42 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 69A1FDDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 07:44:42 +1000 (EST)
Date: Wed, 19 Aug 2009 01:44:40 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH v2 0/6] Device table matching for SPI subsystem
Message-ID: <20090818214440.GA21391@oksana.dev.rtsoft.ru>
References: <20090731003957.GA23982@oksana.dev.rtsoft.ru>
	<1249889723.19638.13.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1249889723.19638.13.camel@localhost>
Cc: Ben Dooks <ben@fluff.org>, David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Jean Delvare <khali@linux-fr.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 10, 2009 at 10:35:23AM +0300, Artem Bityutskiy wrote:
> On Fri, 2009-07-31 at 04:39 +0400, Anton Vorontsov wrote:
> > Andrew,
> > 
> > This new patch set overwrites following patches:
> > 
> >   hwmon-lm70-convert-to-device-table-matching.patch
> >   hwmon-adxx-convert-to-device-table-matching.patch
> >   spi-merge-probe-and-probe_id-callbacks.patch
> >   spi-prefix-modalias-with-spi.patch
> >   of-remove-stmm25p40-alias.patch
> >   mtd-m25p80-convert-to-device-table-matching.patch
> >   spi-add-support-for-device-table-matching.patch
> 
> Are you going to send v3 and address David's comments?

No v3, but I'm going to address David's comments in a follow up
patch set where I'll change the probing code anyway.

> Do you want some of these patches to go via the MTD tree or
> they better go as a series via some other tree?

Um.. The MTD patches depend on SPI subsystem changes... If
David and Andrew are OK with SPI patches going through MTD tree,
then I'm fine with it as well.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
