Return-Path: <pku.leo@gmail.com>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 421TPr181tzF36j
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2018 03:05:03 +1000 (AEST)
Received: by mail-oi0-f66.google.com with SMTP id p84-v6so16721516oic.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 10:05:02 -0700 (PDT)
Received: from mail-oi0-f52.google.com (mail-oi0-f52.google.com.
 [209.85.218.52])
 by smtp.gmail.com with ESMTPSA id m11-v6sm6709869oif.27.2018.08.30.10.05.00
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 30 Aug 2018 10:05:00 -0700 (PDT)
Received: by mail-oi0-f52.google.com with SMTP id t68-v6so16670199oie.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 10:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180829200425.16435-1-robh@kernel.org>
 <VI1PR04MB32475E7E36BA8467FC07B01D91080@VI1PR04MB3247.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB32475E7E36BA8467FC07B01D91080@VI1PR04MB3247.eurprd04.prod.outlook.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Thu, 30 Aug 2018 12:04:48 -0500
Message-ID: <CADRPPNTWQP7kgB8O4LJ67H237z=o8KEscT0i7nveNVFvodb+AA@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl/qe: Use of_get_child_by_name helper
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: Rob Herring <robh@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 29, 2018 at 9:49 PM Qiang Zhao <qiang.zhao@nxp.com> wrote:
>
> From: Rob Herring <robh@kernel.org>
> date: 2018/8/30 4:04
>
> > To: Qiang Zhao <qiang.zhao@nxp.com>
> > Cc: linux-kernel@vger.kernel.org; Leo Li <leoyang.li@nxp.com>;
> > linuxppc-dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org
> > Subject: [PATCH] soc: fsl/qe: Use of_get_child_by_name helper
> >
> > Use the of_get_child_by_name() helper instead of open coding searching for the
> > 'firmware' child node. This removes directly accessing the name pointer as well.
> >
> > Cc: Qiang Zhao <qiang.zhao@nxp.com>
> > Cc: Li Yang <leoyang.li@nxp.com>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Rob Herring <robh@kernel.org>

Merged for next.  Thanks.

Regards,
Leo
