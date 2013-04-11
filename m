Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3B84C2C00B2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 23:35:27 +1000 (EST)
Subject: Re: [PATCHv2] powerpc/crypto: Add property for 'era' in SEC dts
 crypto node
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1365651923-24017-1-git-send-email-vakul@freescale.com>
Date: Thu, 11 Apr 2013 08:34:01 -0500
Message-Id: <7217580C-7107-4A96-9D8C-382AB68A19B0@kernel.crashing.org>
References: <1365651923-24017-1-git-send-email-vakul@freescale.com>
To: Vakul Garg <vakul@freescale.com>
Cc: Shaveta Leekha <shaveta@freescale.com>, linux-kernel@vger.kernel.org,
 Andy Fleming <afleming@freescale.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 10, 2013, at 10:45 PM, Vakul Garg wrote:

> The crypto node now contains a new property 'fsl,sec-era'.
> This is required so that applications can retrieve era info without
> having to be able to read SEC's register space.
> 
> Signed-off-by: Vakul Garg <vakul@freescale.com>
> ---
> Changelog:
> 
> 	v2: Added era in p1023si-post.dtsi as per Kim's comments.
> 
> arch/powerpc/boot/dts/fsl/p1023si-post.dtsi   |    1 +
> arch/powerpc/boot/dts/fsl/pq3-sec4.4-0.dtsi   |    1 +
> arch/powerpc/boot/dts/fsl/qoriq-sec4.0-0.dtsi |    1 +
> arch/powerpc/boot/dts/fsl/qoriq-sec4.2-0.dtsi |    1 +
> arch/powerpc/boot/dts/fsl/qoriq-sec5.0-0.dtsi |    1 +
> arch/powerpc/boot/dts/fsl/qoriq-sec5.2-0.dtsi |    1 +
> arch/powerpc/boot/dts/fsl/qoriq-sec5.3-0.dtsi |    1 +
> 7 files changed, 7 insertions(+), 0 deletions(-)

applied to next

- k
