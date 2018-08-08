Return-Path: <oss@buserror.net>
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41m63Q1XCVzDqkP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 08:47:45 +1000 (AEST)
Date: Wed, 8 Aug 2018 17:47:34 -0500
From: Scott Wood <oss@buserror.net>
To: Camelia Groza <camelia.groza@nxp.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, benh@kernel.crashing.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <20180808224734.GA32575@home.buserror.net>
References: <6fa5aa04d257525c5703b7c8ca833ec0ae0047c7.1531903211.git.camelia.groza@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6fa5aa04d257525c5703b7c8ca833ec0ae0047c7.1531903211.git.camelia.groza@nxp.com>
Subject: Re: [2/3] powerpc/dts/fsl: t4240rdb: use the Cortina PHY driver
 compatible
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 18, 2018 at 02:46:50PM +0300, Camelia Groza wrote:
> The Cortina PHY requires the use of the dedicated Cortina PHY driver
> instead of the generic one.
> 
> Signed-off-by: Camelia Groza <camelia.groza@nxp.com>
> ---
>  arch/powerpc/boot/dts/fsl/t4240rdb.dts | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied with the changelog updated to talk about hardware compatibility
("The Cortina PHY is not compatible with IEEE 802.3 clause 45") rather
than driver choice.

-Scott
