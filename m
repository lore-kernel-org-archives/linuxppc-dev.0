Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 521CCB7804
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 02:31:23 +1100 (EST)
Subject: Re: [PATCH 1/2] powerpc/p2020rdb: move the NAND address.
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1331833228-14903-1-git-send-email-bigeasy@linutronix.de>
Date: Fri, 16 Mar 2012 10:13:46 -0500
Message-Id: <AFD0F023-AB44-4367-9CD2-3D76782800F8@kernel.crashing.org>
References: <1331833228-14903-1-git-send-email-bigeasy@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 15, 2012, at 12:40 PM, Sebastian Andrzej Siewior wrote:

> It is not at 0xffa00000. According to current u-boot source the NAND
> controller is always at 0xff800000 and it is either at CS0 or CS1
> depending on NAND or NAND+NOR mode. In 36bit mode it is shifted to
> 0xfff800000 but it has always an eight there and never an A.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> arch/powerpc/boot/dts/p2020rdb.dts |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

applied

- k
