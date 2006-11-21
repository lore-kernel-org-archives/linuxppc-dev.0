Return-Path: <SRS0+eba91cc084d5cfeb2a16+1185+infradead.org+dwmw2@canuck.srs.infradead.org>
Subject: Re: [PATCH] powerpc: Add of_platform support for ROM devices
From: David Woodhouse <dwmw2@infradead.org>
To: Vitaly Wool <vwool@ru.mvista.com>
In-Reply-To: <20061120163239.f9a38fc1.vwool@ru.mvista.com>
References: <20061120163239.f9a38fc1.vwool@ru.mvista.com>
Content-Type: text/plain
Date: Tue, 21 Nov 2006 17:22:39 +0000
Message-Id: <1164129759.19448.68.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-11-20 at 16:32 +0300, Vitaly Wool wrote:
> +
> +     - device_type : has to be "rom"
> +     - compatible : Should specify what this ROM device is compatible with
> +       (i.e. "onenand"). Currently, this is most likely to be "direct-mapped"
> +       (which corresponds to the MTD physmap mapping driver).

I don't think 'direct-mapped' is particularly necessary -- I think we
have to assume that any NOR flash device is going to be direct-mapped if
we're going to be able to represent it with this scheme.

On the other hand, we _do_ want to specify the type of chip, or at least
the type of _probe_ which should be done for it (jedec vs. cfi). And
optionally also the chip idents.

-- 
dwmw2
