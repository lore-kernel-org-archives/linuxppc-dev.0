Return-Path: <pebolle@tiscali.nl>
Received: from lb1-smtp-cloud3.xs4all.net (lb1-smtp-cloud3.xs4all.net
 [194.109.24.22])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BBF771A0368
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2015 09:54:04 +1000 (AEST)
Message-ID: <1435276439.28572.42.camel@tiscali.nl>
Subject: Re: [v2,5/9] fsl/fman: Add Frame Manager support
From: Paul Bolle <pebolle@tiscali.nl>
To: igal.liberman@freescale.com, netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, scottwood@freescale.com,
 madalin.bucur@freescale.com
Date: Fri, 26 Jun 2015 01:53:59 +0200
In-Reply-To: <1435174555-7008-1-git-send-email-igal.liberman@freescale.com>
References: <1435174555-7008-1-git-send-email-igal.liberman@freescale.com>
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

On Wed, 2015-06-24 at 22:35 +0300, igal.liberman@freescale.com wrote:
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/fman/fm_drv.c

> +u16 fm_get_max_frm(void)
> +{
> +	return fsl_fm_max_frm;
> +}
> +EXPORT_SYMBOL(fm_get_max_frm);

Which module is using this export? (And what does this function
actually do?)

> +int fm_get_rx_extra_headroom(void)
> +{
> +	return ALIGN(fsl_fm_rx_extra_headroom, 16);
> +}
> +EXPORT_SYMBOL(fm_get_rx_extra_headroom);

This exports an unused function.

I don't know how to, well, review a series that adds almost 20K lines.
So I decided to pick one subject: exports. I think I had something to
comment on all eight of them.

I'm not sure if I'll try another scan with a different subject.

Thanks,


Paul Bolle
