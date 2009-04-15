Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 444CCDE273
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 23:53:22 +1000 (EST)
Date: Wed, 15 Apr 2009 15:53:12 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] AOA: Convert onyx and tas codecs to new-style i2c
	drivers (v3)
Message-ID: <20090415155312.7ea73a6a@hyperion.delvare>
In-Reply-To: <1239800444.9071.5.camel@johannes.local>
References: <20090415142225.2bfd37f6@hyperion.delvare>
	<1239800444.9071.5.camel@johannes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Benjamin, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Takashi Iwai <tiwai@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 15 Apr 2009 15:00:44 +0200, Johannes Berg wrote:
> On Wed, 2009-04-15 at 14:22 +0200, Jean Delvare wrote:
> > The legacy i2c binding model is going away soon, so convert the AOA
> > codec drivers to the new model or they'll break.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Cc: Johannes Berg <johannes@sipsolutions.net>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Tested-by: Andreas Schwab <schwab@linux-m68k.org>
> > ---
> > Johannes, this is a reworked patch which assumes that the onyx codec
> > probing can fail. It's not exactly clean but that's the easiest
> > approach for now. Can you please give it a try? Thanks.
> 
> This works.
> Tested-by: Johannes Berg <johannes@sipsolutions.net> [quad G5]

Excellent, thanks for the testing!

-- 
Jean Delvare
