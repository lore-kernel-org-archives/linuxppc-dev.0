Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EE59ADDEC0
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 08:46:51 +1000 (EST)
Subject: Re: [patch 29/30] PS3: Device tree source.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20070613181854.GA723@aepfle.de>
References: <20070612181825.730300780@am.sony.com> >
	<466EEC01.6080807@am.sony.com>
	<f7c4ca74d3e2031e01264f31f09e515a@kernel.crashing.org>
	<20070613084023.GA28629@aepfle.de> <46702AFE.8080800@am.sony.com>
	<20070613181854.GA723@aepfle.de>
Content-Type: text/plain
Date: Thu, 14 Jun 2007 08:46:41 +1000
Message-Id: <1181774801.14818.343.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-06-13 at 20:18 +0200, Olaf Hering wrote:
> 
> Ok, so what will be the final values for name, model and compatible?
> Can you add them to 2.6.22 to fixate them?

No name for the root of the DT.

IMHO, model can be whatever he wants, I would say SonyPS3-XX or
something like that, whatever, doens't matter, the most precise the
better.

Then you want compatible which is the really important one. sony,ps3
looks good to me for that, though you could have a list if you wanted.

Ben.
