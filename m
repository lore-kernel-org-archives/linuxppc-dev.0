Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 89B69B7CF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  7 Apr 2010 20:26:38 +1000 (EST)
Date: Wed, 07 Apr 2010 03:26:40 -0700 (PDT)
Message-Id: <20100407.032640.172296134.davem@davemloft.net>
To: Manfred.Rudigier@omicron.at
Subject: Re: [RFC PATCH net-next 1/4] gianfar: Added stub support for
	SIOCSHWTSTAMP
From: David Miller <davem@davemloft.net>
In-Reply-To: <95DC1AA8EC908B48939B72CF375AA5E311A9F4DF@alice.at.omicron.at>
References: <95DC1AA8EC908B48939B72CF375AA5E311A9F4DF@alice.at.omicron.at>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, sandeep.kumar@freescale.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Manfred Rudigier <Manfred.Rudigier@omicron.at>
Date: Wed, 7 Apr 2010 11:46:08 +0200

> This ioctl command is required for enabling hardware time stamping support
> for network packets, see Documentation/networking/timestamping.txt. At the
> moment nothing will be done for all requests that enable time stamping and
> thus ERANGE will be returned.
> 
> Signed-off-by: Manfred Rudigier <manfred.rudigier@omicron.at>

This is completely pointless.

Something sane should happen so that every driver doesn't
need to add this stub code just to return -ERANGE.
