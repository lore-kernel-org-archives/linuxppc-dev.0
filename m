Return-Path: <jingoohan1@gmail.com>
Received: from mail-io0-x22b.google.com (mail-io0-x22b.google.com
 [IPv6:2607:f8b0:4001:c06::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 30D061A0975
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2015 20:49:11 +1100 (AEDT)
Received: by iouu10 with SMTP id u10so85121508iou.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2015 01:49:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1447336125-5010-1-git-send-email-jszhang@marvell.com>
References: <1447336125-5010-1-git-send-email-jszhang@marvell.com>
Date: Fri, 13 Nov 2015 18:49:08 +0900
Message-ID: <CAPOBaE5AwxQz6pscN3HfMuZjSFU61VLrkmO7DG-r5+czLFkO8w@mail.gmail.com>
Subject: Re: [PATCH] PCI: designware: bail out if host_init failed
From: Han Jingoo <jingoohan1@gmail.com>
To: Jisheng Zhang <jszhang@marvell.com>
Cc: "kishon@ti.com" <kishon@ti.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "kgene@kernel.org" <kgene@kernel.org>,
 "k.kozlowski@samsung.com" <k.kozlowski@samsung.com>,
 "Richard.Zhu@freescale.com" <Richard.Zhu@freescale.com>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
 "m-karicheri2@ti.com" <m-karicheri2@ti.com>,
 "minghuan.Lian@freescale.com" <minghuan.Lian@freescale.com>,
 "mingkai.hu@freescale.com" <mingkai.hu@freescale.com>,
 "tie-fei.zang@freescale.com" <tie-fei.zang@freescale.com>,
 "pratyush.anand@gmail.com" <pratyush.anand@gmail.com>,
 "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Han Jingoo <jingoohan1@gmail.com>
Content-Type: multipart/alternative; boundary=001a113fe6c290e147052468f8ff
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a113fe6c290e147052468f8ff
Content-Type: text/plain; charset=UTF-8

2015. 11. 12. Thusday, Jisheng Zhang<jszhang@marvell.com> wrote:

> There's no reason to continue the initialization such as configure
> register, scan root bus etc. if customized host_init() failed. This
> patch tries to check the host_init result, bail out if failed.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com <javascript:;>>


Acked-by: Jingoo Han <jingoohan1@gmail.com>

---
>  drivers/pci/host/pci-dra7xx.c      |  4 +++-
>  drivers/pci/host/pci-exynos.c      |  4 +++-
>  drivers/pci/host/pci-imx6.c        |  4 +++-
>  drivers/pci/host/pci-keystone.c    |  4 +++-
>  drivers/pci/host/pci-layerscape.c  | 25 ++++++++++++++++---------
>  drivers/pci/host/pcie-designware.c |  7 +++++--
>  drivers/pci/host/pcie-designware.h |  2 +-
>  drivers/pci/host/pcie-spear13xx.c  |  4 +++-
>  8 files changed, 37 insertions(+), 17 deletions(-)
>

--001a113fe6c290e147052468f8ff
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2015. 11. 12.=C2=A0Thusday, Jisheng Zhang&lt;<a href=3D"mailto:jszhang@marv=
ell.com">jszhang@marvell.com</a>&gt; wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">There&#39;s no reason to continue the initialization such as configure<b=
r>
register, scan root bus etc. if customized host_init() failed. This<br>
patch tries to check the host_init result, bail out if failed.<br>
<br>
Signed-off-by: Jisheng Zhang &lt;<a href=3D"javascript:;" onclick=3D"_e(eve=
nt, &#39;cvml&#39;, &#39;jszhang@marvell.com&#39;)">jszhang@marvell.com</a>=
&gt;</blockquote><div><br></div><div>Acked-by: Jingoo Han &lt;<a href=3D"ma=
ilto:jingoohan1@gmail.com">jingoohan1@gmail.com</a>&gt;</div><div><br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">
---<br>
=C2=A0drivers/pci/host/pci-dra7xx.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 +++-<br>
=C2=A0drivers/pci/host/pci-exynos.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 +++-<br>
=C2=A0drivers/pci/host/pci-imx6.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 +++-=
<br>
=C2=A0drivers/pci/host/pci-keystone.c=C2=A0 =C2=A0 |=C2=A0 4 +++-<br>
=C2=A0drivers/pci/host/pci-layerscape.c=C2=A0 | 25 ++++++++++++++++--------=
-<br>
=C2=A0drivers/pci/host/pcie-designware.c |=C2=A0 7 +++++--<br>
=C2=A0drivers/pci/host/pcie-designware.h |=C2=A0 2 +-<br>
=C2=A0drivers/pci/host/pcie-spear13xx.c=C2=A0 |=C2=A0 4 +++-<br>
=C2=A08 files changed, 37 insertions(+), 17 deletions(-)<br>
</blockquote>

--001a113fe6c290e147052468f8ff--
