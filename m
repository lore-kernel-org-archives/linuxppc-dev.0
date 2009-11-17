Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 985E8B6F11
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 11:35:19 +1100 (EST)
Message-ID: <4B02EABA.3060905@grandegger.com>
Date: Tue, 17 Nov 2009 19:26:02 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] net/can: add driver for mscan family & mpc52xx_mscan
References: <1258128892-28800-1-git-send-email-w.sang@pengutronix.de>	<fa686aa40911130939x54ac53f9x173a875a5a4435d3@mail.gmail.com>
	<20091116184416.GA21491@pengutronix.de>
In-Reply-To: <20091116184416.GA21491@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: socketcan-core@lists.berlios.de, David Miller <davem@davemloft.net>,
	linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wolfram Sang wrote:
> Hi Grant,
> 
> Wolfgang commented on some points already, I will pick up the other remarks,
> just one question:
> 
>>> +       clk_src = of_get_property(np, "fsl,mscan-clk-src", NULL);
>>> +       if (clk_src && strcmp(clk_src, "ip") == 0)
>> Should protect against non-null.  strncmp() maybe?
> 
> "ip" is null-terminated, or what do you mean?

Imagine somebody defines:

  fsl,mscan-clk-src = <0xbaeee>;

Wolfgang.
