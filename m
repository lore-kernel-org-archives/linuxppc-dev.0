Return-Path: <richardcochran@gmail.com>
Received: from mail-pl0-x232.google.com (mail-pl0-x232.google.com
 [IPv6:2607:f8b0:400e:c01::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 410YKZ4kGkzF1ls
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 23:57:54 +1000 (AEST)
Received: by mail-pl0-x232.google.com with SMTP id g20-v6so1575252plq.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Jun 2018 06:57:54 -0700 (PDT)
Date: Tue, 5 Jun 2018 06:57:49 -0700
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
Subject: Re: [PATCH 09/10] dpaa_eth: add support for hardware timestamping
Message-ID: <20180605135748.mlarwiyzf2oe27ax@localhost>
References: <20180604070837.19265-1-yangbo.lu@nxp.com>
 <20180604070837.19265-10-yangbo.lu@nxp.com>
 <20180604134920.ezhe6jz5ntpnqyzj@localhost>
 <DB6PR0401MB2536376432EC481473A5B4A3F8660@DB6PR0401MB2536.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DB6PR0401MB2536376432EC481473A5B4A3F8660@DB6PR0401MB2536.eurprd04.prod.outlook.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 05, 2018 at 03:35:28AM +0000, Y.b. Lu wrote:
> [Y.b. Lu] Actually these timestamping codes affected DPAA networking performance in our previous performance test.
> That's why we used ifdef for it.

How much does time stamping hurt performance?

If the time stamping is compiled in but not enabled at run time, does
it still affect performace?

Thanks,
Richard
