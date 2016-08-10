Return-Path: <patrice.chotard@st.com>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8NYC3LHRzDqQb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 17:47:57 +1000 (AEST)
Subject: Re: [STLinux Kernel] [PATCH] i2c: don't print error when adding
 adapter fails
To: Wolfram Sang <wsa-dev@sang-engineering.com>, <linux-kernel@vger.kernel.org>
References: <1470742581-12971-1-git-send-email-wsa-dev@sang-engineering.com>
CC: <linux-samsung-soc@vger.kernel.org>, <kernel@stlinux.com>,
 <adi-buildroot-devel@lists.sourceforge.net>,
 <linux-rockchip@lists.infradead.org>, <linux-i2c@vger.kernel.org>,
 <linux-tegra@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
 <linux-omap@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@lists.infradead.org>
From: Patrice Chotard <patrice.chotard@st.com>
Message-ID: <dda2b522-0257-17c7-1332-cbc026b74603@st.com>
Date: Wed, 10 Aug 2016 08:50:31 +0200
MIME-Version: 1.0
In-Reply-To: <1470742581-12971-1-git-send-email-wsa-dev@sang-engineering.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/09/2016 01:36 PM, Wolfram Sang wrote:
> Since v4.8-rc1, the I2C core will print detailed information when adding an I2C
> adapter fails. So, drivers can skip this now.
>
> I am still undecided if I apply this as a single patch or break it out. But for
> reviewing, avoiding the patch bomb is probably a good thing.
>
> Should go via subsystem tree, I'd think.
>
> Wolfram Sang (1):
>   i2c: don't print error when adding adapter fails
>
>  drivers/i2c/busses/i2c-st.c             | 4 +---
>

For i2c-st.c

Acked-by: Patrice Chotard <patrice.chotard@st.com>

Thanks
