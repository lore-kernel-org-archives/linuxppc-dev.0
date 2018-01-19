Return-Path: <andrew@lunn.ch>
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zNM2W5vGgzF0fB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jan 2018 00:22:57 +1100 (AEDT)
Date: Fri, 19 Jan 2018 14:22:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc: "madalin.bucur@nxp.com" <madalin.bucur@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "madskateman@gmail.com" <madskateman@gmail.com>
Subject: Re: DPAA Ethernet traffice troubles with Linux kernel
Message-ID: <20180119132251.GJ32299@lunn.ch>
References: <CAHkrCmFCzPd_a1UmyfuZHKM4hXvou0uO0FYoG5bd_fxE8QMueg@mail.gmail.com>
 <DB3PR0402MB3849EEF00D71FF7A230B70C3ECEB0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <1516035556.18795.71.camel@infinera.com>
 <20180116143836.GC22903@lunn.ch>
 <1516125454.18795.87.camel@infinera.com>
 <DB3PR0402MB38492999533EB4400DED45BFECE90@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <1516348851.4730.15.camel@infinera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1516348851.4730.15.camel@infinera.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > commit 4d8ee1935bcd666360311dfdadeee235d682d69a
> > Author: Florian Fainelli <f.fainelli@gmail.com>
> > Date: Tue Aug 22 15:24:47 2017 -0700
> > fsl/man: Inherit parent device and of_node
> > 
> > and was later addressed by this patch set:
> > 
> > http://patchwork.ozlabs.org/project/netdev/list/?series=8462&state=*
> > 
> > Even with these errors printed, all is working fine, it's just the
> > second probing that fails. Adding the latter patches or reverting
> > the one above makes the errors prints dissapear.
> 
> Looking at the above patch seriers I see it is in state Accepted and has been there
> since 2017-10-16
> That seems like a awful long to wait in before getting into Linux, is there something
> holding these patches back ?

They are in Linux, have been since October 16th. But at the moment,
they are only in v4.15, not v4.14.

These patches probably don't fit the stable rules, for getting them
added to v4.14.

https://github.com/torvalds/linux/blob/master/Documentation/process/stable-kernel-rules.rst

What is needed is a minimal fix. Or just wait until Sunday, when there
is a good chance v4.15 will be released.

   Andrew
