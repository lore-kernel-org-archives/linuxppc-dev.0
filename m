Return-Path: <lars@metafoo.de>
Received: from smtp-out-124.synserver.de (smtp-out-124.synserver.de
 [212.40.185.124]) by ozlabs.org (Postfix) with ESMTP id 9D3162C0180
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jul 2013 20:04:45 +1000 (EST)
Message-ID: <51E277E5.8050305@metafoo.de>
Date: Sun, 14 Jul 2013 12:05:25 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH RFC 1/8] powerpc: mpc512x_dma: add support for data
 transfers between memory and i/o memory
References: <1373642781-32631-1-git-send-email-gsi@denx.de>
 <1373642781-32631-2-git-send-email-gsi@denx.de>
In-Reply-To: <1373642781-32631-2-git-send-email-gsi@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vinod.koul@intel.com>,
 devicetree-discuss@lists.ozlabs.org, Alexander Popov <a13xp0p0v88@gmail.com>,
 Dan Williams <djbw@fb.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/12/2013 05:26 PM, Gerhard Sittig wrote:
[...]
]
> +		if (mchan->tcd_nunits)
> +			tcd->nbytes = mchan->tcd_nunits * 4;
> +		else
> +			tcd->nbytes = 64;

Just wondering where does the magic 64 come from?
