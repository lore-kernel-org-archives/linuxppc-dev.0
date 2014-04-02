Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-we0-x22c.google.com (mail-we0-x22c.google.com
 [IPv6:2a00:1450:400c:c03::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 92F7D14011A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Apr 2014 04:53:19 +1100 (EST)
Received: by mail-we0-f172.google.com with SMTP id t61so633762wes.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Apr 2014 10:53:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1395326878-25243-1-git-send-email-a13xp0p0v88@gmail.com>
References: <1395326878-25243-1-git-send-email-a13xp0p0v88@gmail.com>
Date: Wed, 2 Apr 2014 21:53:13 +0400
Message-ID: <CAF0T0X5MKaexM1kRWx=hv8B9i7WLQPLoi+-wTo7dLz2WP=rCcA@mail.gmail.com>
Subject: Re: [PATCH RFC v10 0/6] MPC512x DMA slave s/g support, OF DMA lookup
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, Gerhard Sittig <gsi@denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Arnd Bergmann <arnd@arndb.de>,
 dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Anatolij Gustschin <agust@denx.de>,
 Vinod Koul <vinod.koul@intel.com>, a13xp0p0v88@gmail.com
Content-Type: multipart/alternative; boundary=089e013c60bc5f189a04f612f562
Cc: devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--089e013c60bc5f189a04f612f562
Content-Type: text/plain; charset=ISO-8859-1

Hello

20.03.2014 18:48 "Alexander Popov" <a13xp0p0v88@gmail.com> wrote:
> Changes in v10:
>  Part 2/6:
>  - don't use direction field of dma_slave_config in
mpc_dma_device_control()
>     but store settings in mpc_dma_chan for both DMA_DEV_TO_MEM and
>     DMA_MEM_TO_DEV cases; then retrieve the needed values in
>     mpc_dma_prep_slave_sg();
>  - fix style issue and put 2014 instead of 2013;
>  Part 3/6:
>  - fix mpc_dma_probe() error path and mpc_dma_remove(): manually free
IRQs and
>     dispose IRQ mappings before devm_* takes care of other resources;
>  Part 6/6:
>  - change according the new part 3/6;
>  - fix style issue;

Could I have a feedback?
Thanks!

> Alexander Popov (5):
>   dma: mpc512x: reorder mpc8308 specific instructions
>   dma: mpc512x: add support for peripheral transfers
>   dma: mpc512x: fix freeing resources in mpc_dma_probe() and
>     mpc_dma_remove()
>   dma: of: Add common xlate function for matching by channel id
>   dma: mpc512x: register for device tree channel lookup
>
> Gerhard Sittig (1):
>   dma: mpc512x: add device tree binding document
>
>  .../devicetree/bindings/dma/mpc512x-dma.txt        |  55 ++++
>  arch/powerpc/boot/dts/mpc5121.dtsi                 |   1 +
>  drivers/dma/mpc512x_dma.c                          | 345
++++++++++++++++++---
>  drivers/dma/of-dma.c                               |  35 +++
>  include/linux/of_dma.h                             |   4 +
>  5 files changed, 402 insertions(+), 38 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/mpc512x-dma.txt
>
> --
> 1.8.4.2
>

Best regards,
Alexander

--089e013c60bc5f189a04f612f562
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Hello</p>
<p dir=3D"ltr">20.03.2014 18:48 &quot;Alexander Popov&quot; &lt;<a href=3D"=
mailto:a13xp0p0v88@gmail.com">a13xp0p0v88@gmail.com</a>&gt; wrote:<br>
&gt; Changes in v10:<br>
&gt; =A0Part 2/6:<br>
&gt; =A0- don&#39;t use direction field of dma_slave_config in mpc_dma_devi=
ce_control()<br>
&gt; =A0 =A0 but store settings in mpc_dma_chan for both DMA_DEV_TO_MEM and=
<br>
&gt; =A0 =A0 DMA_MEM_TO_DEV cases; then retrieve the needed values in<br>
&gt; =A0 =A0 mpc_dma_prep_slave_sg();<br>
&gt; =A0- fix style issue and put 2014 instead of 2013;<br>
&gt; =A0Part 3/6:<br>
&gt; =A0- fix mpc_dma_probe() error path and mpc_dma_remove(): manually fre=
e IRQs and<br>
&gt; =A0 =A0 dispose IRQ mappings before devm_* takes care of other resourc=
es;<br>
&gt; =A0Part 6/6:<br>
&gt; =A0- change according the new part 3/6;<br>
&gt; =A0- fix style issue;</p>
<p dir=3D"ltr">Could I have a feedback?<br>
Thanks!</p>
<p dir=3D"ltr">&gt; Alexander Popov (5):<br>
&gt; =A0 dma: mpc512x: reorder mpc8308 specific instructions<br>
&gt; =A0 dma: mpc512x: add support for peripheral transfers<br>
&gt; =A0 dma: mpc512x: fix freeing resources in mpc_dma_probe() and<br>
&gt; =A0 =A0 mpc_dma_remove()<br>
&gt; =A0 dma: of: Add common xlate function for matching by channel id<br>
&gt; =A0 dma: mpc512x: register for device tree channel lookup<br>
&gt;<br>
&gt; Gerhard Sittig (1):<br>
&gt; =A0 dma: mpc512x: add device tree binding document<br>
&gt;<br>
&gt; =A0.../devicetree/bindings/dma/mpc512x-dma.txt =A0 =A0 =A0 =A0| =A055 =
++++<br>
&gt; =A0arch/powerpc/boot/dts/mpc5121.dtsi =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 1 +<br>
&gt; =A0drivers/dma/mpc512x_dma.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| 345 ++++++++++++++++++---<br>
&gt; =A0drivers/dma/of-dma.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 | =A035 +++<br>
&gt; =A0include/linux/of_dma.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 | =A0 4 +<br>
&gt; =A05 files changed, 402 insertions(+), 38 deletions(-)<br>
&gt; =A0create mode 100644 Documentation/devicetree/bindings/dma/mpc512x-dm=
a.txt<br>
&gt;<br>
&gt; --<br>
&gt; 1.8.4.2<br>
&gt;</p>
<p dir=3D"ltr">Best regards,<br>
Alexander</p>

--089e013c60bc5f189a04f612f562--
