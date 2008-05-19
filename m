Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 7D716DDED6
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 15:09:50 +1000 (EST)
Date: Sun, 18 May 2008 22:09:44 -0700 (PDT)
Message-Id: <20080518.220944.147901584.davem@davemloft.net>
To: galak@kernel.crashing.org
Subject: Re: [PATCH v2] lmb: Fix compile warning
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0805182333550.10619@blarg.am.freescale.net>
References: <1211136296-4572-2-git-send-email-galak@kernel.crashing.org>
	<20080518.203116.199516667.davem@davemloft.net>
	<Pine.LNX.4.64.0805182333550.10619@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kumar Gala <galak@kernel.crashing.org>
Date: Sun, 18 May 2008 23:34:36 -0500 (CDT)

> lib/lmb.c: In function 'lmb_dump_all':
> lib/lmb.c:51: warning: format '%lx' expects type 'long unsigned int', but argument 2 has type 'u64'
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Acked-by: David S. Miller <davem@davemloft.net>
