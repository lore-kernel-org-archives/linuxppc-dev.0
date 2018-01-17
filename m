Return-Path: <andrew@lunn.ch>
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zM7bQ14yRzDqGc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 00:43:44 +1100 (AEDT)
Date: Wed, 17 Jan 2018 14:43:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "madalin.bucur@nxp.com" <madalin.bucur@nxp.com>,
 "madskateman@gmail.com" <madskateman@gmail.com>
Subject: Re: DPAA Ethernet traffice troubles with Linux kernel
Message-ID: <20180117134339.GC32299@lunn.ch>
References: <CAHkrCmFCzPd_a1UmyfuZHKM4hXvou0uO0FYoG5bd_fxE8QMueg@mail.gmail.com>
 <DB3PR0402MB3849EEF00D71FF7A230B70C3ECEB0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <1516035556.18795.71.camel@infinera.com>
 <20180116143836.GC22903@lunn.ch>
 <1516125454.18795.87.camel@infinera.com>
 <20180116205342.GA29888@lunn.ch>
 <1516189651.18795.99.camel@infinera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1516189651.18795.99.camel@infinera.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> That doesn't work really, having users to hit the bug, debug it, fix it and then
> find it fixed already in upstream, then specifically request it to be backported to stable. 
> I don't need this fix to be backported, already got it. Someone else might though.

The "someone else might though" is a big point of asking for it to
added to stable. The other reason is it means one less patch you need
to maintain in your build.

> I would be interested in bug fixes upstream which fixes:

Did you try upstream? Does it give the same errors?

    Andrew
