Return-Path: <elendil@planet.nl>
Received: from CPSMTPM-EML109.kpnxchange.com (Cpsmtpm-eml109.kpnxchange.com
	[195.121.3.13]) by ozlabs.org (Postfix) with ESMTP id 4515DB7C48
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 08:30:35 +1100 (EST)
From: Frans Pop <elendil@planet.nl>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 00/09] net: remove trailing spaces in messages
Date: Wed, 24 Mar 2010 22:30:31 +0100
References: <201003241840.18701.elendil@planet.nl>
	<20100324.141158.43422101.davem@davemloft.net>
In-Reply-To: <20100324.141158.43422101.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201003242230.34217.elendil@planet.nl>
Cc: jon.maloy@ericsson.com, samuel@sortiz.org,
	e1000-devel@lists.sourceforge.net, per.liden@ericsson.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, allan.stephens@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 24 March 2010, David Miller wrote:
> All applied, but I have to make some fixups.
>
> For example, GIT warns about trailing whitespace on any lines that you
> touched so I had to fix those up before putting them into the tree.

I did wonder about fixing that or not. But as the surrounding code also has 
tons of trailing whitespace, I chose to leave things consistently messy.

I'll remove at least trailing whitespace next time.

Thanks David.
