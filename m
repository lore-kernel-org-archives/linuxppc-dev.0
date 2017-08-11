Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTPFy1ZhJzDr38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 22:19:50 +1000 (AEST)
In-Reply-To: <20170725114004.17819-1-ivan@de.ibm.com>
To: Ivan Mikhaylov <ivan@de.ibm.com>, Alistair Popple <alistair@popple.id.au>,
 Matt Porter <mporter@kernel.crashing.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Patrice Chotard <patrice.chotard@st.com>, Ulf Hansson <ulf.hansson@linaro.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Rob Herring <robh@kernel.org>, kernel@stlinux.com,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Joel Stanley <joel@jms.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2,2/2] 44x/fsp2: enable eMMC arasan for fsp2 platform
Message-Id: <3xTPFy0gq8z9t3G@ozlabs.org>
Date: Fri, 11 Aug 2017 22:19:49 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-07-25 at 11:40:04 UTC, Ivan Mikhaylov wrote:
> Add mmc0 changes for enabling arasan emmc and change
> defconfig appropriately.
> 
> Signed-off-by: Ivan Mikhaylov <ivan@de.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/754f030908c3615781e9e3559d8ba1

cheers
