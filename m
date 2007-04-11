Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 94B59DDF14
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 16:16:52 +1000 (EST)
Date: Wed, 11 Apr 2007 08:17:30 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [PATCH] autodetect serial console on efika
Message-ID: <20070411061730.GA9091@aepfle.de>
References: <20070331150823.GA25421@aepfle.de>
	<461A3817.8080303@genesi-usa.com>
	<20070410165246.GC508@aepfle.de> <461BF2CC.7090502@246tNt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <461BF2CC.7090502@246tNt.com>
Cc: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 10, Sylvain Munaut wrote:

> In all those cases, the ttyPSC0 is bogus ...

Thats why I asked for the number of enabled serial console drivers in
the firmware. I suspect there is just a single one for the onboard
connector.
