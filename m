Return-Path: <catalin.marinas@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xtKbP10txzDrWn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 23:47:28 +1000 (AEST)
Date: Thu, 14 Sep 2017 14:47:25 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Roy Pledge <roy.pledge@nxp.com>
Cc: leoyang.li@nxp.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 mark.rutland@arm.com, arnd@arndb.de, madalin.bucur@nxp.com,
 linux@armlinux.org.uk, oss@buserror.net
Subject: Re: [v4 03/11] dt-bindings: soc/fsl: Update reserved memory binding
 for QBMan
Message-ID: <20170914134725.gltucphoi4lsqxpf@localhost>
References: <1503607075-28970-1-git-send-email-roy.pledge@nxp.com>
 <1503607075-28970-4-git-send-email-roy.pledge@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503607075-28970-4-git-send-email-roy.pledge@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 24, 2017 at 04:37:47PM -0400, Roy Pledge wrote:
> Updates the QMan and BMan device tree bindings for reserved memory
> nodes. This makes the reserved memory allocation compatible with
> the shared-dma-pool usage.
> 
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
> ---
>  Documentation/devicetree/bindings/soc/fsl/bman.txt | 12 +++++-----
>  Documentation/devicetree/bindings/soc/fsl/qman.txt | 26 ++++++++++++++++------

This needs reviewed by the DT maintainers.

-- 
Catalin
