Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 067A11A0B51
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 00:46:01 +1100 (AEDT)
Date: Thu, 22 Oct 2015 15:46:46 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Alexander Popov <alex.popov@linux.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Rob Herring
 <robh@kernel.org>, Timur Tabi <timur@tabi.org>, Grant Likely
 <grant.likely@linaro.org>, Dan Williams <dan.j.williams@intel.com>, Vinod
 Koul <vinod.koul@intel.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland
 <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar
 Gala <galak@codeaurora.org>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] powerpc/512x: add a device tree binding for
 LocalPlus Bus FIFO
Message-ID: <20151022154646.590d7b03@crub>
In-Reply-To: <1444597682-22181-3-git-send-email-alex.popov@linux.com>
References: <1444597682-22181-1-git-send-email-alex.popov@linux.com>
 <1444597682-22181-3-git-send-email-alex.popov@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 12 Oct 2015 00:08:02 +0300
Alexander Popov <alex.popov@linux.com> wrote:

> Add a device tree binding for Freescale MPC512x LocalPlus Bus FIFO and
> introduce the document describing that binding.
> 
> Signed-off-by: Alexander Popov <alex.popov@linux.com>
> ---
>  .../bindings/powerpc/fsl/mpc512x_lpbfifo.txt        | 21 +++++++++++++++++++++
>  arch/powerpc/boot/dts/mpc5121.dtsi                  | 11 +++++++++--
>  arch/powerpc/boot/dts/mpc5125twr.dts                | 11 ++++++++++-
>  3 files changed, 40 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/mpc512x_lpbfifo.txt

applied to mpc5xxx/next.

Thanks,

Anatolij
