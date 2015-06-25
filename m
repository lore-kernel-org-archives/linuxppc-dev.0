Return-Path: <pebolle@tiscali.nl>
Received: from lb2-smtp-cloud3.xs4all.net (lb2-smtp-cloud3.xs4all.net
 [194.109.24.26])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0C9781A0368
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2015 09:06:36 +1000 (AEST)
Message-ID: <1435273590.28572.11.camel@tiscali.nl>
Subject: Re: [v2,9/9] fsl/fman: Add FMan MAC driver
From: Paul Bolle <pebolle@tiscali.nl>
To: igal.liberman@freescale.com, netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, scottwood@freescale.com,
 madalin.bucur@freescale.com
Date: Fri, 26 Jun 2015 01:06:30 +0200
In-Reply-To: <1435174672-4608-1-git-send-email-igal.liberman@freescale.com>
References: <1435174672-4608-1-git-send-email-igal.liberman@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(Evolution 3.16 is basically unbearable for replying to patches. Anyone
else running into this?) 

On Wed, 2015-06-24 at 22:37 +0300, igal.liberman@freescale.com wrote:
> 
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/fman/mac/mac-api.c
> +int set_mac_active_pause(struct mac_device *mac_dev, bool rx, bool tx)
> +{
> +	[...]
> +}
> +EXPORT_SYMBOL(set_mac_active_pause);

Which module is using this function?

> +void get_pause_cfg(struct mac_device *mac_dev, bool *rx_pause, bool *tx_pause)
> +{
> +	[...]
> +}
> +EXPORT_SYMBOL(get_pause_cfg);

This exports a function that is only used in this file. Why? 

Thanks,


Paul Bolle
