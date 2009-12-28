Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id B2591B7BEB
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Dec 2009 16:54:54 +1100 (EST)
Date: Sun, 27 Dec 2009 21:54:54 -0800 (PST)
Message-Id: <20091227.215454.226776048.davem@davemloft.net>
To: cbouatmailru@gmail.com
Subject: Re: [PATCH 1/3] phylib: Fix deadlock on resume
From: David Miller <davem@davemloft.net>
In-Reply-To: <20091222221447.GA9268@oksana.dev.rtsoft.ru>
References: <20091222221447.GA9268@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linux-pm@lists.linux-foundation.org,
	afleming@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Vorontsov <cbouatmailru@gmail.com>
Date: Wed, 23 Dec 2009 01:14:47 +0300

> Sometimes kernel hangs on resume with the following trace:
 ...
> This patch fixes the issue by stopping the state machine on suspend
> and starting it again on resume.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Applied.
