Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A8E762C02A9
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jul 2013 22:03:59 +1000 (EST)
Message-ID: <1373285027.4446.36.camel@pasglop>
Subject: Re: question about the e200 support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Hao <haokexin@gmail.com>
Date: Mon, 08 Jul 2013 22:03:47 +1000
In-Reply-To: <20130708115951.GD1005@pek-khao-d1.corp.ad.wrs.com>
References: <20130708115951.GD1005@pek-khao-d1.corp.ad.wrs.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-07-08 at 19:59 +0800, Kevin Hao wrote:
> It seems that Kumar added the e200 core support for linux in 2005. But we
> never add a e200 board since then. I doubt if anyone will do that in the
> future. Is this just reserved for out of tree users? If not, how about
> drop the e200 core support from kernel? It will definitely make the
> e500 code more readable without all these useless #ifdef for CONFIG_E200.
> What are you guys opinions?

I'll leave the decision to Scott and Kumar, I'm personally happy to drop it
if there is no in-tree user.

BTW. People still using 8xx ?

Cheers,
Ben.
