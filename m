Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 8543CB7BAB
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 02:54:00 +1100 (EST)
Message-ID: <4B02C6ED.5050004@grandegger.com>
Date: Tue, 17 Nov 2009 16:53:17 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: updates to the mscan-driver in net-next
References: <1258412274-14686-1-git-send-email-w.sang@pengutronix.de>
	<20091117.035416.250564986.davem@davemloft.net>
In-Reply-To: <20091117.035416.250564986.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: socketcan-core@lists.berlios.de, netdev@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Miller wrote:
> From: Wolfram Sang <w.sang@pengutronix.de>
> Date: Mon, 16 Nov 2009 23:57:43 +0100
> 
>> here are the patches which fix the issues for the mscan & mpc52xx_can drivers
>> raised by Wolfgang Grandegger and Grant Likely. They are based on the initial
>> version of the drivers I sent a few days ago. Devicetree-discuss has been added
>> for the property changes. I will also update my branch on pengutronix.de
>> tomorrow, I seem to have issues when trying that from home :(^
> 
> All applied to net-next-2.6, thank you.

Puh, I'm again too late for commenting, testing and adding my
signed-off-by line. Nevertheless, the driver looks good and works fine now.

Thanks,

Wolfgang.
