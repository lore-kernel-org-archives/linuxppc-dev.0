Return-Path: <andrew@lunn.ch>
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLYQk6swDzF0Vm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 02:04:14 +1100 (AEDT)
Date: Tue, 16 Jan 2018 16:04:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: mad skateman <madskateman@gmail.com>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>,
 Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "madalin.bucur@nxp.com" <madalin.bucur@nxp.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: DPAA Ethernet traffice troubles with Linux kernel
Message-ID: <20180116150411.GG22903@lunn.ch>
References: <CAHkrCmFCzPd_a1UmyfuZHKM4hXvou0uO0FYoG5bd_fxE8QMueg@mail.gmail.com>
 <DB3PR0402MB3849EEF00D71FF7A230B70C3ECEB0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <1516035556.18795.71.camel@infinera.com>
 <346361be-ce30-6a13-c154-5192d2668723@xenosoft.de>
 <32f11c91-9529-180a-a8cf-9f380f853b99@xenosoft.de>
 <CAHkrCmFwMRh7+9ijRhgpqm_dQmE7uH8pv8ZQvLY1rxk1hjhfzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHkrCmFwMRh7+9ijRhgpqm_dQmE7uH8pv8ZQvLY1rxk1hjhfzw@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> When i use mii-tool too Kick the tranceiver... it comes alive.. i can
> ping the eth0 itself
> 
> root@X5000LNX:/home/skateman# mii-tool -R eth0
> resetting the transceiver...
> root@X5000LNX:/home/skateman# ping 192.168.22.44
> PING 192.168.22.44 (192.168.22.44) 56(84) bytes of data.
> 64 bytes from 192.168.22.44: icmp_seq=1 ttl=64 time=0.045 ms
> 64 bytes from 192.168.22.44: icmp_seq=2 ttl=64 time=0.046 ms
> 64 bytes from 192.168.22.44: icmp_seq=3 ttl=64 time=0.047 ms
> 64 bytes from 192.168.22.44: icmp_seq=4 ttl=64 time=0.048 ms

What PHY driver are you using?

This smells a bit like an RGMII-ID problem.

     Andrew
