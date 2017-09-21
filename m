Return-Path: <catalin.marinas@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xyfDz2WMLzDr5Q
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 00:31:31 +1000 (AEST)
Date: Thu, 21 Sep 2017 15:31:26 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Roy Pledge <roy.pledge@nxp.com>
Cc: leoyang.li@nxp.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, mark.rutland@arm.com, arnd@arndb.de,
 madalin.bucur@nxp.com, linux@armlinux.org.uk, oss@buserror.net,
 Claudiu Manoil <claudiu.manoil@nxp.com>
Subject: Re: [v5 05/12] soc/fsl/qbman: Drop set/clear_bits usage
Message-ID: <20170921143125.yfqswiovu36bal6l@localhost>
References: <1505767187-4596-1-git-send-email-roy.pledge@nxp.com>
 <1505767187-4596-6-git-send-email-roy.pledge@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1505767187-4596-6-git-send-email-roy.pledge@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 18, 2017 at 04:39:40PM -0400, Roy Pledge wrote:
> From: Madalin Bucur <madalin.bucur@nxp.com>
> 
> Replace PPC specific set/clear_bits API with standard
> bit twiddling so driver is portalable outside PPC.
> 
> Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
