Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EF6DADDDF7
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 07:59:36 +1100 (EST)
Subject: Re: [PATCH 2/11] ibm_newemac: Add ET1011c PHY support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20071130142904.GC3117@lixom.net>
References: <1196401223.5661.297518056501.qpush@grosgo>
	<20071130054126.E3EFADDE0C@ozlabs.org>
	<20071130142904.GC3117@lixom.net>
Content-Type: text/plain
Date: Sat, 01 Dec 2007 07:59:16 +1100
Message-Id: <1196456356.13230.104.camel@pasglop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-11-30 at 08:29 -0600, Olof Johansson wrote:
> Hi,
> 
> On Fri, Nov 30, 2007 at 04:40:24PM +1100, Benjamin Herrenschmidt wrote:
> 
> > This adds support for the Agere ET1011c PHY as found on the AMCC Taishan
> > board.
> 
> The whole patch has whitespace messed up (tabs vs spaces).

Thanks for noticing it on the ...3rd time those are sent to the list...

Ben.
