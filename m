Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by ozlabs.org (Postfix) with ESMTP id E2EB2B6F06
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Jul 2010 09:11:22 +1000 (EST)
Received: by gwaa20 with SMTP id a20so3279886gwa.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 13 Jul 2010 16:11:20 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100713230352.6781.18644.stgit@angua>
References: <20100713230352.6781.18644.stgit@angua>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 13 Jul 2010 17:11:00 -0600
Message-ID: <AANLkTilG016R6nnpy7COX4NZE6qWWO8ILvHAyyT4-bgV@mail.gmail.com>
Subject: Re: [RFC PATCH] Kconfig: Enable Kconfig fragments to be used for
	defconfig
To: linuxppc-dev@lists.ozlabs.org, Nicolas Pitre <nico@fluxnic.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Russell King <rmk@arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tony Lindgren <tony@atomide.com>, Daniel Walker <dwalker@codeaurora.org>,
	=?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Typo correction:

2010/7/13 Grant Likely <grant.likely@secretlab.ca>:
[...]
> <board>.Kconfig defines new board specific config items (prefixed with
> "generateconfig_" which default to 'y' or 'm' and select the options
> that the platform cares about. =A0It also then either the architecture

s/either the/either includes the/

> default Kconfig, or another Kconfig fragment that includes the default
> one (therefore the fragments can be 'stacked' to include, say, default
> options for the architecture, or particular chipset).
[...]
