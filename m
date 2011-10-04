Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 160B7B6F70
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Oct 2011 17:02:31 +1100 (EST)
Subject: Re: [PATCH] mlx4_en: fix transmit of packages when blue frame is
	enabled
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
In-Reply-To: <20111003205358.GB3596@oc1711230544.ibm.com>
References: <1317388995-411-1-git-send-email-cascardo@linux.vnet.ibm.com>
	<953B660C027164448AE903364AC447D2235D9A8C@MTLDAG02.mtl.com>
	<20111003143721.GA3596@oc1711230544.ibm.com>
	<953B660C027164448AE903364AC447D2235DAA9D@MTLDAG02.mtl.com>
	<20111003205358.GB3596@oc1711230544.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 04 Oct 2011 08:02:12 +0200
Message-ID: <1317708132.29415.213.camel@pasglop>
Mime-Version: 1.0
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Eli Cohen <eli@mellanox.co.il>,
	"eli@dev.mellanox.co.il" <eli@dev.mellanox.co.il>,
	linuxppc-dev@lists.ozlabs.org, Yevgeny Petrilin <yevgenyp@mellanox.co.il>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-10-03 at 17:53 -0300, Thadeu Lima de Souza Cascardo wrote:

 .../...

> > Can you also send me the output of ethtool -i?
> > It seems that there is a problem with write combining on Power processors, we will check this issue.
> > 
> > Yevgeny
> 
> Hello, Yevgeny.
> 
> You will find the output of ethtool -i below.
> 
> I am copying Ben and powerpc list, in case this is an issue with Power
> processors. They can provide us some more insight into this.

May I get some background please ? :-)

I'm not aware of a specific issue with write combining but I'd need to
know more about what you are doing and the code to do it to comment on
whether it should work or not.

Cheers,
Ben.
