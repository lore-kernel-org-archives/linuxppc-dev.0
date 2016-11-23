Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNtgz2GztzDw2p
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 18:07:27 +1100 (AEDT)
Message-ID: <1479884833.21746.44.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Jia Hongtao <hongtao.jia@nxp.com>, rui.zhang@intel.com,
 edubezval@gmail.com,  robh+dt@kernel.org, scott.wood@nxp.com,
 shawnguo@kernel.org
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Wed, 23 Nov 2016 01:07:13 -0600
In-Reply-To: <1477361742-589-1-git-send-email-hongtao.jia@nxp.com>
References: <1477361742-589-1-git-send-email-hongtao.jia@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH V3 1/2] powerpc/mpc85xx: Update TMU device tree node for
 T1040/T1042
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-10-25 at 10:15 +0800, Jia Hongtao wrote:
> From: Hongtao Jia <hongtao.jia@nxp.com>
> 
> Update #thermal-sensor-cells from 0 to 1 according to the new binding. The
> sensor specifier added is the monitoring site ID, and represents the "n" in
> TRITSRn and TRATSRn.
> 
> Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>

Where can I find this new binding?  As of the current linux-next I don't see
anything in qoriq-thermal.txt about this.

-Scott
