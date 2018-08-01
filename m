Return-Path: <richardcochran@gmail.com>
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gNMY29JxzF10S
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 16:15:20 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id b11-v6so2114635pfo.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 23:15:19 -0700 (PDT)
Date: Tue, 31 Jul 2018 23:15:15 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: "Y.b. Lu" <yangbo.lu@nxp.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Madalin-cristian Bucur <madalin.bucur@nxp.com>,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] ptp_qoriq: convert to use module parameters for
 initialization
Message-ID: <20180801061515.krn52iaq2kqdi3wo@localhost>
References: <20180730100154.27906-1-yangbo.lu@nxp.com>
 <20180730100154.27906-3-yangbo.lu@nxp.com>
 <20180730143043.qu66ttzwyjbw6si7@localhost>
 <DB6PR0401MB253643010802739AD55820F3F82D0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DB6PR0401MB253643010802739AD55820F3F82D0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 01, 2018 at 04:36:40AM +0000, Y.b. Lu wrote:

> Could I add a function to calculate a set of default register values
> to initialize ptp timer when dts method failed to get required
> properties in driver?

Yes, it would be ideal if the driver can pick correct values
automatically.

However, the frequency on the FIPER outputs can't be configured
automatically, and we don't have an API for the user to choose this.

> I think this will be useful. The ptp timer on new platforms (you may
> see two dts patches in this patchset. Many platforms will be
> affected.) will work without these dts properties. If user want
> specific setting, they can set dts properties.

Sure.

Thanks,
Richard
