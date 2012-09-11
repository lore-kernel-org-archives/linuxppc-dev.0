Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D32E02C0089
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2012 17:08:32 +1000 (EST)
Message-ID: <1347347286.2603.43.camel@pasglop>
Subject: Re: [PATCH 13/25] macintosh/mediabay: add a const qualifier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Date: Tue, 11 Sep 2012 17:08:06 +1000
In-Reply-To: <20120911065604.GE28643@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1343034810-3386-14-git-send-email-u.kleine-koenig@pengutronix.de>
 <1346812817.2257.23.camel@pasglop> <20120905080249.GI28643@pengutronix.de>
 <1346837023.2257.57.camel@pasglop> <20120911065604.GE28643@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <rob.herring@calxeda.com>,
 kernel@pengutronix.de, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-09-11 at 08:56 +0200, Uwe Kleine-König wrote:
> 
> in the hope I didn't interpret "anything powerpc" too wide. Please
> tell me if I did. 

No, it's fine with me, give me a git URL if you want me to run that
through my various config test builds.

Cheers,
Ben.
