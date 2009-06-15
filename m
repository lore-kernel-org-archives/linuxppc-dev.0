Return-Path: <davem@davemloft.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6EB31B70E6
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 18:50:17 +1000 (EST)
Date: Mon, 15 Jun 2009 01:50:15 -0700 (PDT)
Message-Id: <20090615.015015.89190735.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 23/33] net/ps3: gelic - Add missing annotations
From: David Miller <davem@davemloft.net>
In-Reply-To: <1245047484.19217.39.camel@pasglop>
References: <1244644748-24211-23-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-24-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1245047484.19217.39.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: Geert.Uytterhoeven@sonycom.com, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 15 Jun 2009 16:31:24 +1000

> On Wed, 2009-06-10 at 16:38 +0200, Geert Uytterhoeven wrote:
>> probe functions should be __devinit
>> 
>> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
>> Cc: Geoff Levand <geoffrey.levand@am.sony.com>
> 
> Please send to netdev or get an ack from davem.

Acked-by: David S. Miller <davem@davemloft.net>

:-)
