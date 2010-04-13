Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id C17B1B7C67
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 13 Apr 2010 18:52:39 +1000 (EST)
Date: Tue, 13 Apr 2010 01:52:42 -0700 (PDT)
Message-Id: <20100413.015242.155130766.davem@davemloft.net>
To: Manfred.Rudigier@omicron.at
Subject: Re: [PATCH v2 net-next 1/2] gianfar: Add hardware RX timestamping
	support
From: David Miller <davem@davemloft.net>
In-Reply-To: <95DC1AA8EC908B48939B72CF375AA5E311B26A77@alice.at.omicron.at>
References: <95DC1AA8EC908B48939B72CF375AA5E311B26A77@alice.at.omicron.at>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sandeep.kumar@freescale.com, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Manfred Rudigier <Manfred.Rudigier@omicron.at>
Date: Fri, 9 Apr 2010 11:10:03 +0200

> The device is configured to insert hardware timestamps into all
> received packets. The RX timestamps are extracted from the padding
> alingment bytes during the clean_rx_ring operation and copied into the
> skb_shared_hwtstamps struct of the skb. This extraction only happens if
> the rx_filter was set to something else than HWTSTAMP_FILTER_NONE with
> the SIOCSHWTSTAMP ioctl command.
> 
> Hardware timestamping is only supported for eTSEC devices. To indicate
> device support the new FSL_GIANFAR_DEV_HAS_TIMER flag was introduced.
> 
> Signed-off-by: Manfred Rudigier <manfred.rudigier@omicron.at>

Applied to net-next-2.6
