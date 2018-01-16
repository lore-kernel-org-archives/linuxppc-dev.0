Return-Path: <andrew@lunn.ch>
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLjB32X2MzF0Tf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 07:53:47 +1100 (AEDT)
Date: Tue, 16 Jan 2018 21:53:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "madalin.bucur@nxp.com" <madalin.bucur@nxp.com>,
 "madskateman@gmail.com" <madskateman@gmail.com>
Subject: Re: DPAA Ethernet traffice troubles with Linux kernel
Message-ID: <20180116205342.GA29888@lunn.ch>
References: <CAHkrCmFCzPd_a1UmyfuZHKM4hXvou0uO0FYoG5bd_fxE8QMueg@mail.gmail.com>
 <DB3PR0402MB3849EEF00D71FF7A230B70C3ECEB0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <1516035556.18795.71.camel@infinera.com>
 <20180116143836.GC22903@lunn.ch>
 <1516125454.18795.87.camel@infinera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1516125454.18795.87.camel@infinera.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > You appear to be using an old kernel. Take a look at:
> 
> Not really, I am using 4.14.x and I don't think that is old.

Development for 4.14 stopped somewhere around the beginning of
September. So there has been over 4 months of work since then.  We are
clearly interested in fixing bugs in that kernel, since it is the
current stable version. But when reporting bugs, please let is know if
the latest version of the network kernel,
it://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git has
the issue.

> Seems like this patch hasn't been sent to 4.14.x.

If it fixes a bug for you, please request the fix is added to stable.

   Andrew
