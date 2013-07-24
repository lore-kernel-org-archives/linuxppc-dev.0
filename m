Return-Path: <pku.leo@gmail.com>
Received: from mail-lb0-x22c.google.com (mail-lb0-x22c.google.com
 [IPv6:2a00:1450:4010:c04::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C58762C008C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 16:34:16 +1000 (EST)
Received: by mail-lb0-f172.google.com with SMTP id a16so178834lbj.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 23:34:11 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <1374646870-5162-1-git-send-email-hongbo.zhang@freescale.com>
References: <1374646870-5162-1-git-send-email-hongbo.zhang@freescale.com>
Date: Wed, 24 Jul 2013 14:34:10 +0800
Message-ID: <CADRPPNQ9hRKq4UFOBaDzGyBO9jbH49mHexEBghLQWmZd_1kLRQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] DMA: Freescale: Add support for 8-channel DMA
 engine
From: Li Yang <leoli@freescale.com>
To: hongbo.zhang@freescale.com
Content-Type: multipart/alternative; boundary=089e013d1742eda87e04e23c189b
Cc: devicetree@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>,
 lkml <linux-kernel@vger.kernel.org>, djbw@fb.com,
 Scott Wood <scottwood@freescale.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--089e013d1742eda87e04e23c189b
Content-Type: text/plain; charset=UTF-8

On Wed, Jul 24, 2013 at 2:21 PM, <hongbo.zhang@freescale.com> wrote:

> From: Hongbo Zhang <hongbo.zhang@freescale.com>
>
> Hi Vinod, Dan, Scott and Leo, please have a look at these V2 patches.
>

Looks good now after rounds of review.

Acked-by: Li Yang <leoli@freescale.com>


>
> Freescale QorIQ T4 and B4 introduce new 8-channel DMA engines, this patch
> set
> adds support this DMA engine.
>
> V4->V5 changes:
> - update description in the dt binding document, to make it more resonable
> - add new patch [4/4] to eliminate a compiling warning which already exists
>   for a long time
>
> V3->V4 changes:
> - introduce new patch [1/3] to revise the legacy dma binding document
> - and then add new paragraph to describe new dt node binding in [2/3]
> - rebase to latest kernel v3.11-rc1
>
> V2->V3 changes:
> - edit Documentation/devicetree/bindings/powerpc/fsl/dma.txt
> - edit text string in Kconfig and the driver files, using "elo series" to
>   mention all the current "elo*"
>
> V1->V2 changes:
> - removed the codes handling the register dgsr1, since it isn't used
> corrently
> - renamed the DMA DT compatible to "fsl,elo3-dma"
> - renamed the new dts files to "elo3-dma-<n>.dtsi"
>
> Hongbo Zhang (4):
>   DMA: Freescale: revise device tree binding document
>   DMA: Freescale: Add new 8-channel DMA engine device tree nodes
>   DMA: Freescale: update driver to support 8-channel DMA engine
>   DMA: Freescale: eliminate a compiling warning
>
>  .../devicetree/bindings/powerpc/fsl/dma.txt        |  118
> +++++++++++++++-----
>  arch/powerpc/boot/dts/fsl/b4si-post.dtsi           |    4 +-
>  arch/powerpc/boot/dts/fsl/elo3-dma-0.dtsi          |   81 ++++++++++++++
>  arch/powerpc/boot/dts/fsl/elo3-dma-1.dtsi          |   81 ++++++++++++++
>  arch/powerpc/boot/dts/fsl/t4240si-post.dtsi        |    4 +-
>  drivers/dma/Kconfig                                |    9 +-
>  drivers/dma/fsldma.c                               |   11 +-
>  drivers/dma/fsldma.h                               |    2 +-
>  8 files changed, 269 insertions(+), 41 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/fsl/elo3-dma-0.dtsi
>  create mode 100644 arch/powerpc/boot/dts/fsl/elo3-dma-1.dtsi
>
> --
> 1.7.9.5
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>



-- 
- Leo

--089e013d1742eda87e04e23c189b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><div class=3D"gmail_quote">=
On Wed, Jul 24, 2013 at 2:21 PM,  <span dir=3D"ltr">&lt;<a href=3D"mailto:h=
ongbo.zhang@freescale.com" target=3D"_blank">hongbo.zhang@freescale.com</a>=
&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">From: Hongbo Zhang &lt;<a href=3D"mailto:hon=
gbo.zhang@freescale.com">hongbo.zhang@freescale.com</a>&gt;<br>
<br>
Hi Vinod, Dan, Scott and Leo, please have a look at these V2 patches.<br></=
blockquote><div><br></div><div>Looks good now after rounds of review.</div>=
<div><br></div><div>Acked-by: Li Yang &lt;<a href=3D"mailto:leoli@freescale=
.com">leoli@freescale.com</a>&gt;</div>
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Freescale QorIQ T4 and B4 introduce new 8-channel DMA engines, this patch s=
et<br>
adds support this DMA engine.<br>
<br>
V4-&gt;V5 changes:<br>
- update description in the dt binding document, to make it more resonable<=
br>
- add new patch [4/4] to eliminate a compiling warning which already exists=
<br>
=C2=A0 for a long time<br>
<br>
V3-&gt;V4 changes:<br>
- introduce new patch [1/3] to revise the legacy dma binding document<br>
- and then add new paragraph to describe new dt node binding in [2/3]<br>
- rebase to latest kernel v3.11-rc1<br>
<br>
V2-&gt;V3 changes:<br>
- edit Documentation/devicetree/bindings/powerpc/fsl/dma.txt<br>
- edit text string in Kconfig and the driver files, using &quot;elo series&=
quot; to<br>
=C2=A0 mention all the current &quot;elo*&quot;<br>
<br>
V1-&gt;V2 changes:<br>
- removed the codes handling the register dgsr1, since it isn&#39;t used co=
rrently<br>
- renamed the DMA DT compatible to &quot;fsl,elo3-dma&quot;<br>
- renamed the new dts files to &quot;elo3-dma-&lt;n&gt;.dtsi&quot;<br>
<br>
Hongbo Zhang (4):<br>
=C2=A0 DMA: Freescale: revise device tree binding document<br>
=C2=A0 DMA: Freescale: Add new 8-channel DMA engine device tree nodes<br>
=C2=A0 DMA: Freescale: update driver to support 8-channel DMA engine<br>
=C2=A0 DMA: Freescale: eliminate a compiling warning<br>
<br>
=C2=A0.../devicetree/bindings/powerpc/fsl/dma.txt =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0118 +++++++++++++++-----<br>
=C2=A0arch/powerpc/boot/dts/fsl/b4si-post.dtsi =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 =C2=A04 +-<br>
=C2=A0arch/powerpc/boot/dts/fsl/elo3-dma-0.dtsi =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 81 ++++++++++++++<br>
=C2=A0arch/powerpc/boot/dts/fsl/elo3-dma-1.dtsi =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 81 ++++++++++++++<br>
=C2=A0arch/powerpc/boot/dts/fsl/t4240si-post.dtsi =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 =C2=A04 +-<br>
=C2=A0drivers/dma/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=
=A09 +-<br>
=C2=A0drivers/dma/fsldma.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 11 +-<br>
=C2=A0drivers/dma/fsldma.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +=
-<br>
=C2=A08 files changed, 269 insertions(+), 41 deletions(-)<br>
=C2=A0create mode 100644 arch/powerpc/boot/dts/fsl/elo3-dma-0.dtsi<br>
=C2=A0create mode 100644 arch/powerpc/boot/dts/fsl/elo3-dma-1.dtsi<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
1.7.9.5<br>
<br>
<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-kernel=
&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at =C2=A0<a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><b=
r>
Please read the FAQ at =C2=A0<a href=3D"http://www.tux.org/lkml/" target=3D=
"_blank">http://www.tux.org/lkml/</a><br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r>- Leo
</div></div>

--089e013d1742eda87e04e23c189b--
