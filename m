Return-Path: <andrew@lunn.ch>
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zcDgL2LVCzF15R
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Feb 2018 08:17:33 +1100 (AEDT)
Date: Wed, 7 Feb 2018 22:17:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: mad skateman <madskateman@gmail.com>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>,
 Madalin-cristian Bucur <madalin.bucur@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Jamie Krueger <jamie@bitbybitsoftwaregroup.com>
Subject: Re: DPAA Ethernet traffice troubles with Linux kernel
Message-ID: <20180207211725.GA27167@lunn.ch>
References: <1516125454.18795.87.camel@infinera.com>
 <20180116205342.GA29888@lunn.ch>
 <1516189651.18795.99.camel@infinera.com>
 <20180117134339.GC32299@lunn.ch>
 <DB3PR0402MB3849850266808EC52F88A783ECE90@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <DB3PR0402MB3849865056493075A4F4317CECE90@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <DB3PR0402MB38494AC5EE923A10053745DDECE90@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <CAHkrCmGxFUbfEyufdYhFYA4jyOkh+W2z=1yZsZwv+O4t+hE_1w@mail.gmail.com>
 <1d62c827-0ff7-0372-a2f8-f1930e9f788c@xenosoft.de>
 <CAHkrCmGrp3eUKYqRpv4__qw24yvL3Fou+MNwaDCX=XGgmFqRRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHkrCmGrp3eUKYqRpv4__qw24yvL3Fou+MNwaDCX=XGgmFqRRg@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 07, 2018 at 10:00:45PM +0100, mad skateman wrote:
> Hi,
> 
> I just found out that something goes wrong within the ARP table (well thats
> what i think). I hope someone has a clue..

This looks like 'normal' behaviour. It has been reported that the
device runs out of buffers. That means it will fail to receive ARP
replies. So the ARP entry will time out and be removed, as it should.

Fix the buffer problem, and ARP will likely work properly.

    Andrew
