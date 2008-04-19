Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id 733CDDE26F
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 12:31:58 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so217099anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 19:31:58 -0700 (PDT)
Message-ID: <fa686aa40804181931p2b18d728q794a0c5c19d1e3b7@mail.gmail.com>
Date: Fri, 18 Apr 2008 20:31:57 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH 2/2] [POWERPC] Xilinx: Virtex: Enable dcr for MMIO and
	NATIVE
In-Reply-To: <20080418215513.C8D1A44007F@mail114-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1206914576.10388.132.camel@pasglop>
	<1208555704-8978-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<20080418215513.C8D1A44007F@mail114-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 18, 2008 at 3:55 PM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
> FPGA designs may have need of both MMIO-based and NATIVE-based dcr
>  interfaces.
>
>  Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
>  ---
>   arch/powerpc/platforms/40x/Kconfig |    2 ++
>   1 files changed, 2 insertions(+), 0 deletions(-)
>
>  diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
>  index a9260e2..b8e06df 100644
>  --- a/arch/powerpc/platforms/40x/Kconfig
>  +++ b/arch/powerpc/platforms/40x/Kconfig
>  @@ -123,6 +123,8 @@ config 405GPR
>
>   config XILINX_VIRTEX
>         bool
>  +       select PPC_DCR_MMIO
>  +       select PPC_DCR_NATIVE

Yeah; we'll probably want to be more sophisticated about this in the
future; but for now...

Acked-by: Grant Likely <grant.likely@secretlab.ca>

(Paulus; but this does depend on patch 1 of this series)

>
>   config XILINX_VIRTEX_II_PRO
>         bool
>  --
>  1.5.3.4-dirty
>
>
>
>  _______________________________________________
>  Linuxppc-dev mailing list
>  Linuxppc-dev@ozlabs.org
>  https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
