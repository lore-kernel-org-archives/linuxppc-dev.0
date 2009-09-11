Return-Path: <davem@davemloft.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BCBEDB7C05
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Sep 2009 05:19:38 +1000 (EST)
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 7DEF2DDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Sep 2009 05:19:38 +1000 (EST)
Date: Fri, 11 Sep 2009 12:19:50 -0700 (PDT)
Message-Id: <20090911.121950.207367910.davem@davemloft.net>
To: timur@freescale.com
Subject: Re: [PATCH 2/3] ucc_geth: Rearrange some code to avoid forward
	declarations
From: David Miller <davem@davemloft.net>
In-Reply-To: <4AA8F880.1000300@freescale.com>
References: <20090910020140.GB31083@oksana.dev.rtsoft.ru>
	<4AA8F880.1000300@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org, afleming@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Timur Tabi <timur@freescale.com>
Date: Thu, 10 Sep 2009 08:00:48 -0500

> Anton Vorontsov wrote:
>> We'll need ugeth_disable() and ugeth_enable() calls earlier in the
>> file, so rearrange some code to avoid forward declarations.
>> 
>> The patch doesn't contain any functional changes.
>> 
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> 
> Acked-by: Timur Tabi <timur@freescale.com>

Applied.
