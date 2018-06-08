Return-Path: <richardcochran@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4128Wg5ndpzF32c
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 14:27:11 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id i5-v6so7487154plt.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jun 2018 21:27:11 -0700 (PDT)
Date: Thu, 7 Jun 2018 21:27:06 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: netdev@vger.kernel.org, madalin.bucur@nxp.com,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v3, 00/10] Support DPAA PTP clock and timestamping
Message-ID: <20180608042706.7gfg5p6574ntc2lq@localhost>
References: <20180607092050.46128-1-yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180607092050.46128-1-yangbo.lu@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 07, 2018 at 05:20:40PM +0800, Yangbo Lu wrote:
> This patchset is to support DPAA FMAN PTP clock and HW timestamping.
> It had been verified on both ARM platform and PPC platform.
> - The patch #1 to patch #5 are to support DPAA FMAN 1588 timer in
>   ptp_qoriq driver.
> - The patch #6 to patch #10 are to add HW timestamping support in
>   DPAA ethernet driver.

Right now, net-next is closed for new stuff.  You will have to post
the series again after the merge window closes.  You can check the
status here:

    http://vger.kernel.org/~davem/net-next.html

When you do re-post, you can add my:

Acked-by: Richard Cochran <richardcochran@gmail.com>
