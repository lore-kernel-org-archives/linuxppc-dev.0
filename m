Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id EE336B6F6B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Apr 2011 06:46:37 +1000 (EST)
Date: Thu, 28 Apr 2011 13:46:03 -0700 (PDT)
Message-Id: <20110428.134603.15230365.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: linux-next: ibmveth runtime errors
From: David Miller <davem@davemloft.net>
In-Reply-To: <20110428121124.39c036ff.sfr@canb.auug.org.au>
References: <20110427144901.4c3f79b3.sfr@canb.auug.org.au>
	<20110427103622.GA22781@rere.qmqm.pl>
	<20110428121124.39c036ff.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=euc-kr
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	mirq-linux@rere.qmqm.pl, santil@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 28 Apr 2011 12:11:24 +1000

> From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
> Date: Thu, 28 Apr 2011 11:59:15 +1000
> Subject: [PATCH] net: ibmveth: force reconfiguring checksum settings on
>  startup
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Commit b9367bf3ee6d ("net: ibmveth: convert to hw_features") accidentally
> removed call to ibmveth_set_csum_offload() in ibmveth_probe(). Put the
> call back where it was, but with additional error checking provided
> by ibmveth_set_features().
> 
> Signed-off-by: Micha©© Miros©©aw <mirq-linux@rere.qmqm.pl>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> [sfr: dev -> netdev]
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Applied, thanks everyone.
