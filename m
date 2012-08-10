Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C84C52C00C5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2012 22:58:37 +1000 (EST)
Subject: Re: [PATCH 1/2] powerpc/p4080ds: dts - add usb controller version
 info and port0
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1344595712-12804-1-git-send-email-Shengzhou.Liu@freescale.com>
Date: Fri, 10 Aug 2012 07:57:50 -0500
Message-Id: <2FA3587E-46B0-485E-87EE-90D777C47F3A@kernel.crashing.org>
References: <1344595712-12804-1-git-send-email-Shengzhou.Liu@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 10, 2012, at 5:48 AM, Shengzhou Liu wrote:

> Add the missing usb controller version info and port0, which is
> required during setup usb phy.
> 
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> ---
> arch/powerpc/boot/dts/fsl/p4080si-post.dtsi |    7 +++++++
> 1 files changed, 7 insertions(+), 0 deletions(-)

applied to merge

- k
