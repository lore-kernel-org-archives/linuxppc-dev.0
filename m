Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id B3186B7DF6
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 13 Apr 2010 18:52:45 +1000 (EST)
Date: Tue, 13 Apr 2010 01:52:48 -0700 (PDT)
Message-Id: <20100413.015248.139841458.davem@davemloft.net>
To: Manfred.Rudigier@omicron.at
Subject: Re: [PATCH v2 net-next 2/2] gianfar: Add hardware TX timestamping
	support
From: David Miller <davem@davemloft.net>
In-Reply-To: <95DC1AA8EC908B48939B72CF375AA5E311B26A78@alice.at.omicron.at>
References: <95DC1AA8EC908B48939B72CF375AA5E311B26A78@alice.at.omicron.at>
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
Date: Fri, 9 Apr 2010 11:10:35 +0200

> If a packet has the skb_shared_tx->hardware flag set the device is
> instructed to generate a TX timestamp and write it back to memory after
> the frame is transmitted. During the clean_tx_ring operation the
> timestamp will be extracted and copied into the skb_shared_hwtstamps
> struct of the skb.
> 
> TX timestamping is enabled by setting the tx_type to something else
> than HWTSTAMP_TX_OFF with the SIOCSHWTSTAMP ioctl command. It is only
> supported by eTSEC devices.
> 
> Signed-off-by: Manfred Rudigier <manfred.rudigier@omicron.at>

Applied to net-next-2.6
