Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C9B501A009A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 10:52:20 +1100 (AEDT)
Date: Tue, 8 Mar 2016 17:52:16 -0600
From: Scott Wood <oss@buserror.net>
To: Dongsheng Wang <dongsheng.wang@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org
Message-ID: <20160308235216.GA579@home.buserror.net>
References: <1453450747-12147-1-git-send-email-dongsheng.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453450747-12147-1-git-send-email-dongsheng.wang@nxp.com>
Subject: Re: powerpc: p1022: add two functions for reset pci slot
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 22, 2016 at 04:19:07PM +0800, Dongsheng Wang wrote:
> +void p1022ds_reset_pcie_slot(void)
> +{
> +	if (px_ctl_altacc_flag)
> +		indirect_access_pixis_reset_pcie_slot();
> +	else
> +		direct_access_pixis_reset_pcie_slot();
> +}

This function is not called anywhere, and I don't see any dependent
patches that do so.

-Scott
