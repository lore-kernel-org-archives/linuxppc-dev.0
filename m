Return-Path: <SRS0+6268839a6384cbb21a2e+1002+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6E81967A2E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 May 2006 08:20:54 +1000 (EST)
Subject: Re: Viable PPC platform?
From: David Woodhouse <dwmw2@infradead.org>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20060522221556.E60273526CA@atlas.denx.de>
References: <20060522221556.E60273526CA@atlas.denx.de>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 May 2006 23:21:00 +0100
Message-Id: <1148336460.10288.37.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2006-05-23 at 00:15 +0200, Wolfgang Denk wrote:
> But then, a 400 MHz Geode is a bit faster than a 50 MHz 8xx, probably
> not only in terms of CPU performance but  also  in  terms  of  memory
> bandwidth.

It's actually NAND flash, and the bandwidth sucks (the flash controller
on the Geode companion chip is quite slow). We're getting about 3 MiB/s
from it, although we _ought_ to be able to get 3½. I'm playing with
JFFS2 some more before I go back to tweaking the NAND drivers though.

-- 
dwmw2
