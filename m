Return-Path: <lars@metafoo.de>
Received: from smtp-out-184.synserver.de (smtp-out-184.synserver.de
 [212.40.185.184]) by ozlabs.org (Postfix) with ESMTP id EFEFE2C0087
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Aug 2013 17:11:06 +1000 (EST)
Message-ID: <51FF5041.1020609@metafoo.de>
Date: Mon, 05 Aug 2013 09:12:01 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Nicolin Chen <b42378@freescale.com>
Subject: Re: [alsa-devel] [PATCH v2 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
References: <1375682965-3116-1-git-send-email-b42378@freescale.com>
 <1375682965-3116-2-git-send-email-b42378@freescale.com>
In-Reply-To: <1375682965-3116-2-git-send-email-b42378@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, timur@tabi.org,
 rob.herring@calxeda.com, broonie@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/05/2013 08:09 AM, Nicolin Chen wrote:
> This patch add S/PDIF controller driver for Freescale SoC.
> 
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

You are supposed to only add tags (Acked-by, Reviewed-by, Signed-off-by,
etc.) for other people if they have explicitly said they are OK with it.
Reviewed-by means that the person has looked at the current patch and thinks
it looks good, not that the person has commented on a previous version of
the patch.

> Signed-off-by: Nicolin Chen <b42378@freescale.com>
[...]
