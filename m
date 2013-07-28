Return-Path: <vinod.koul@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by ozlabs.org (Postfix) with ESMTP id A2E642C012D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jul 2013 00:30:12 +1000 (EST)
Date: Sun, 28 Jul 2013 19:21:17 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: hongbo.zhang@freescale.com
Subject: Re: [PATCH v6 3/3] DMA: Freescale: update driver to support
 8-channel DMA engine
Message-ID: <20130728135117.GG1986@intel.com>
References: <1374834436-7149-1-git-send-email-hongbo.zhang@freescale.com>
 <1374834436-7149-4-git-send-email-hongbo.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1374834436-7149-4-git-send-email-hongbo.zhang@freescale.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, djbw@fb.com,
 scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 26, 2013 at 06:27:16PM +0800, hongbo.zhang@freescale.com wrote:
> From: Hongbo Zhang <hongbo.zhang@freescale.com>
> 
> This patch adds support to 8-channel DMA engine, thus the driver works for both
> the new 8-channel and the legacy 4-channel DMA engines.
> 
> Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
This looks fine. I need someone to ACK the DT bindings for the series to go in

~Vinod
