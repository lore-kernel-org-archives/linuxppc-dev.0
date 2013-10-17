Return-Path: <lars@metafoo.de>
Received: from smtp-out-233.synserver.de (smtp-out-233.synserver.de
 [212.40.185.233]) by ozlabs.org (Postfix) with ESMTP id E42A42C016E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 23:29:33 +1100 (EST)
Message-ID: <525FD65B.3040004@metafoo.de>
Date: Thu, 17 Oct 2013 14:21:47 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Timur Tabi <timur@tabi.org>
Subject: Re: [alsa-devel] [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio
 Interface driver.
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
 <525FD4C7.3050806@tabi.org>
In-Reply-To: <525FD4C7.3050806@tabi.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org,
 linux-doc@vger.kernel.org, tiwai@suse.de, b18965@freescale.com,
 linux-kernel@vger.kernel.org, r65073@freescale.com, LW@KARO-electronics.de,
 linux@arm.linux.org.uk, b42378@freescale.com,
 Xiubo Li <Li.Xiubo@freescale.com>, oskar@scara.com, grant.likely@linaro.org,
 devicetree@vger.kernel.org, ian.campbell@citrix.com, pawel.moll@arm.com,
 swarren@wwwdotorg.org, rob.herring@calxeda.com, broonie@kernel.org,
 linux-arm-kernel@lists.infradead.org, fabio.estevam@freescale.com,
 lgirdwood@gmail.com, rob@landley.net, r64188@freescale.com,
 shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/17/2013 02:15 PM, Timur Tabi wrote:
> Xiubo Li wrote:
>> +    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +    sai->base = devm_ioremap_resource(&pdev->dev, res);
> 
> Why not use of_iomap()?

Because it won't check for conflicting resource regions.

- Lars
