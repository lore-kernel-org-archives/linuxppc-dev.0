Return-Path: <swarren@wwwdotorg.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org
 [IPv6:2001:470:1f0f:bd7::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EBDE02C007C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 12:33:48 +1000 (EST)
Message-ID: <504FF489.6040307@wwwdotorg.org>
Date: Tue, 11 Sep 2012 20:33:45 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: Re: [alsa-devel] [PATCH 3/5] ASoC: fsl: mpc5200-soc-audio driver
References: <1347416089-23393-1-git-send-email-emillbrandt@dekaresearch.com>
 <1347416089-23393-4-git-send-email-emillbrandt@dekaresearch.com>
In-Reply-To: <1347416089-23393-4-git-send-email-emillbrandt@dekaresearch.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: alsa-devel@alsa-project.org,
 Mark Brown <broonie@opensource.wolfsonmicro.com>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org,
 Liam Girdwood <lrg@ti.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/11/2012 08:14 PM, Eric Millbrandt wrote:
> Add a generic mpc5200 driver that allows asoc cards to be defined in the
> device tree.

> +++ b/Documentation/devicetree/bindings/powerpc/fsl/mpc5200.txt

> +A sound node is defined for each asoc platform.  A sound node must
> +have at least one child DAI node.
> +- card-name           - The card name to register in asoc
> +- audio-platform      - Contains a phandle to a ac97 or i2s node
> +- number-of-dais      - The number of DAIs defined

Can't you get that value simply by counting all the child nodes? It
seems redundant.
