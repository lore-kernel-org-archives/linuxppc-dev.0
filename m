Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CE46F1007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 19 Dec 2009 09:09:34 +1100 (EST)
Subject: Re: [PATCH] ps3_gelic_wireless: Fix build failure due to missing
	WEXT_PRIV
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
In-Reply-To: <20091218085547.fb8bdaf5.randy.dunlap@oracle.com>
References: <1261115574.2173.18.camel@pasglop>
	<20091218085547.fb8bdaf5.randy.dunlap@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 19 Dec 2009 09:09:11 +1100
Message-ID: <1261174151.2173.66.camel@pasglop>
Mime-Version: 1.0
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-wireless@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-12-18 at 08:55 -0800, Randy Dunlap wrote:
> 
> Probably also needs
>         depends on WLAN
> to prevent build failures.

Yeah, GELIC_WIRELESS should probably. I'll do a separate patch next week
but feel free to beat me to it.

Cheers,
Ben.
