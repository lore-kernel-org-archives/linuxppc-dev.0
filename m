Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EB26ADDDFB
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2008 10:34:00 +1100 (EST)
Message-Id: <289FAE78-B927-4DA9-A952-C949BDAD71A1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Ron Madrid <ron_madrid@sbcglobal.net>
In-Reply-To: <1225926686-5891-1-git-send-email-ron_madrid@sbcglobal.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] Add support for Marvell 88E1118 PHY
Date: Wed, 5 Nov 2008 17:33:55 -0600
References: <1225926686-5891-1-git-send-email-ron_madrid@sbcglobal.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 5, 2008, at 5:11 PM, Ron Madrid wrote:

> This patch will add support for the Marvell 88E1118 PHY which  
> supports gigabit ethernet among other things.
>
> Signed-off-by: Ron Madrid <ron_madrid@sbcglobal.net>
> ---
> drivers/net/phy/marvell.c |   66 ++++++++++++++++++++++++++++++++++++ 
> +++++++++
> 1 files changed, 66 insertions(+), 0 deletions(-)

This patch should be sent to the netdev list.

- k
