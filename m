Return-Path: <SRS0+d99126679a6468e47a3e+1563+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D7F6EDDF31
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 05:12:26 +1100 (EST)
Subject: Re: [PATCH 2.6.24] pasemi_mac: Fix reuse of free'd skb
From: David Woodhouse <dwmw2@infradead.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <1196791478.13978.359.camel@pmac.infradead.org>
References: <20071204033414.GA13616@lixom.net>
	<1196791478.13978.359.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Tue, 04 Dec 2007 18:12:17 +0000
Message-Id: <1196791937.13978.362.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: ranger@gentoo.org, netdev@vger.kernel.org, jgarzik@pobox.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-12-04 at 18:04 +0000, David Woodhouse wrote:
> Oops: Exception in kernel mode, sig: 5 [#1]                                     
> nfs: server pmac not responding, still trying         

Oops, sorry. That was meant to be just to Olof. And it helps if I'm
actually running the kernel in which his patch is applied, too...

-- 
dwmw2
