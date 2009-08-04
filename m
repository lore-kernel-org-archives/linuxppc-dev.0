Return-Path: <david-b@pacbell.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3CC4FB6F31
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Aug 2009 10:28:32 +1000 (EST)
Received: from n24.bullet.mail.mud.yahoo.com (n24.bullet.mail.mud.yahoo.com
	[68.142.206.163]) by ozlabs.org (Postfix) with SMTP id 785CDDDD04
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Aug 2009 10:28:31 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 0/7] Device table matching for SPI subsystem
Date: Mon, 3 Aug 2009 19:16:02 -0700
References: <20090729170345.GA26787@oksana.dev.rtsoft.ru>
In-Reply-To: <20090729170345.GA26787@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200908031916.02880.david-b@pacbell.net>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Jean Delvare <khali@linux-fr.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 29 July 2009, Anton Vorontsov wrote:
> 	platform_data is overkill for m25p80 chips, the
> driver only needs to know exact chip model, and that's what device
> tables are for.

To be fair, the platform_data also supports partitioning
and labeling e.g. for cmdlinepart ... though I'd tend to
agree that most SPI flash chips are kind of small (so
they're mostly just one smallish partition).
