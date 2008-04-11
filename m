Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 6ACC4DE154
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 17:06:32 +1000 (EST)
Subject: Re: [PATCH 1/5] phylib: don't create a phydev for ID-less PHYs.
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <4764055962e0a42ce083783bbb897a62090ad90b.1207846542.git.paul.gortmaker@windriver.com>
References: <1207849922-2436-1-git-send-email-paul.gortmaker@windriver.com>
	<4764055962e0a42ce083783bbb897a62090ad90b.1207846542.git.paul.gortmaker@windriver.com>
Content-Type: text/plain
Date: Fri, 11 Apr 2008 09:06:29 +0200
Message-Id: <1207897589.9544.13.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org, linux-net@vger.kernel.org
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-04-10 at 13:51 -0400, Paul Gortmaker wrote:
> I've tested on 8360, 8540 and 8641D and in all cases, the PHY
> ID returned for bus addr 0x1f is all zeros, and not all 0xf.
> This means we've been allocating a phydev for this "ghost".
> 
> In addition to marking 0x0 as an invalid PHY ID, I've also
> changed the existing somewhat useless printk to actually
> list the bus IDs where it found a PHY so we get a basic
> bus summary.
 
PHY ID 0x0 isn't an invalid id, I got a Broadcom PHY that has
PHY ID=0. Maybe I am misunderstanding something?

 Jocke
