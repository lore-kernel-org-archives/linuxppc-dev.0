Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 7C0EFDE1D5
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 18:06:55 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org,
 joakim.tjernlund@transmode.se
Subject: Re: [PATCH 1/5] phylib: don't create a phydev for ID-less PHYs.
Date: Fri, 11 Apr 2008 10:06:04 +0200
References: <1207849922-2436-1-git-send-email-paul.gortmaker@windriver.com>
	<4764055962e0a42ce083783bbb897a62090ad90b.1207846542.git.paul.gortmaker@windriver.com>
	<1207897589.9544.13.camel@gentoo-jocke.transmode.se>
In-Reply-To: <1207897589.9544.13.camel@gentoo-jocke.transmode.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804111006.04708.sr@denx.de>
Cc: scottwood@freescale.com, Paul Gortmaker <paul.gortmaker@windriver.com>,
	linux-net@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 11 April 2008, Joakim Tjernlund wrote:
> On Thu, 2008-04-10 at 13:51 -0400, Paul Gortmaker wrote:
> > In addition to marking 0x0 as an invalid PHY ID, I've also
> > changed the existing somewhat useless printk to actually
> > list the bus IDs where it found a PHY so we get a basic
> > bus summary.
>
> PHY ID 0x0 isn't an invalid id, I got a Broadcom PHY that has
> PHY ID=0. Maybe I am misunderstanding something?

IIRC, address 0 is the PHY broadcast address, but can be used without problem 
with some PHY's. I remember some designs were we had the PHY at address 0.

Best regards,
Stefan
