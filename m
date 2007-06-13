Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id D805FDDE0F
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 04:18:47 +1000 (EST)
Date: Wed, 13 Jun 2007 20:18:54 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch 29/30] PS3: Device tree source.
Message-ID: <20070613181854.GA723@aepfle.de>
References: <20070612181825.730300780@am.sony.com>>
	<466EEC01.6080807@am.sony.com>
	<f7c4ca74d3e2031e01264f31f09e515a@kernel.crashing.org>
	<20070613084023.GA28629@aepfle.de> <46702AFE.8080800@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <46702AFE.8080800@am.sony.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 13, Geoff Levand wrote:

> If this was set as PS3PF, then there would be no
> way to tell that an incompatible DT has been passed.

Ok, so what will be the final values for name, model and compatible?
Can you add them to 2.6.22 to fixate them?
