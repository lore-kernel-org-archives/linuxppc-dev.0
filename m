Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 39C46B6EF5
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Dec 2009 21:52:46 +1100 (EST)
Date: Wed, 09 Dec 2009 02:52:45 -0800 (PST)
Message-Id: <20091209.025245.152622485.davem@davemloft.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] gianfar: Fix build with CONFIG_NET_POLL_CONTROLLER=y
From: David Miller <davem@davemloft.net>
In-Reply-To: <20091209104427.GA25526@oksana.dev.rtsoft.ru>
References: <1260341804.16132.22.camel@pasglop>
	<20091209104427.GA25526@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: Sandeep.Kumar@freescale.com, linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Wed, 9 Dec 2009 13:44:27 +0300

> commit 46ceb60ca80fa07703bc6eb8f4651f900dff5a82 ("gianfar: Add
> Multiple group Support") introduced the following build error
> with CONFIG_NET_POLL_CONTROLLER=y:
 ...
> This patch fixes the issue.
> 
> Reported-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Applied, but this shows that netconsole needs some serious
testing with this drive now :-/

Thanks.
