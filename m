Return-Path: <andrew@lunn.ch>
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLjLC3tFzzF0ZG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 08:00:50 +1100 (AEDT)
Date: Tue, 16 Jan 2018 22:00:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: mad skateman <madskateman@gmail.com>
Cc: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "madalin.bucur@nxp.com" <madalin.bucur@nxp.com>
Subject: Re: DPAA Ethernet traffice troubles with Linux kernel
Message-ID: <20180116210048.GB29888@lunn.ch>
References: <CAHkrCmFCzPd_a1UmyfuZHKM4hXvou0uO0FYoG5bd_fxE8QMueg@mail.gmail.com>
 <DB3PR0402MB3849EEF00D71FF7A230B70C3ECEB0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <1516035556.18795.71.camel@infinera.com>
 <20180116143836.GC22903@lunn.ch>
 <1516125454.18795.87.camel@infinera.com>
 <CAHkrCmE5GzvkKTm5=Yy5QxKOL_OJn+9xrWLjhH=Zayg_nsQt7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHkrCmE5GzvkKTm5=Yy5QxKOL_OJn+9xrWLjhH=Zayg_nsQt7A@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> *Given this if we disable that bit, we get the matching "Universally
> Administered Address" 00000100 (Binary), 04 (Hex) -> "04:00:00", hence my
> question:"*
> 
> This has something to do with the MAC adresses being locally administered
> .. and since whe can use Uboot and choose any Mac addr we want, this could
> make sense..

You cannot just flip this bit. Universally administered addresses are
allocated by the IEEE. You need to purchase them from the IEEE.
Locally administered MAC addresses you can use, and any sane DHCP
server should work with them.

This also does not fit with mii-tool -R observation.

     Andrew
