Return-Path: <festevam@gmail.com>
Received: from mail-ua0-x22e.google.com (mail-ua0-x22e.google.com
 [IPv6:2607:f8b0:400c:c08::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sNCtY2dc2zDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 23:59:00 +1000 (AEST)
Received: by mail-ua0-x22e.google.com with SMTP id l94so183600093ual.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 06:59:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1472467915-21317-1-git-send-email-wente.wang@nxp.com>
References: <1472467915-21317-1-git-send-email-wente.wang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 29 Aug 2016 10:58:57 -0300
Message-ID: <CAOMZO5B3FDPxm301Hwb+ZVOwYDAMU0vjcVAG0hH36Rf2+s0VDA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Support non-ssi cpu-dai for sgtl5000
To: Winter Wang <wente.wang@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 29, 2016 at 7:51 AM, Winter Wang <wente.wang@nxp.com> wrote:
> These patches support sgtl5000 to be attached to other non-ssi cpu-dais like SAI.

Do we really need this?

We can use SAI with sgtl5000 just fine via simple card. Take a look at:
https://git.kernel.org/cgit/linux/kernel/git/shawnguo/linux.git/commit/arch/arm/boot/dts/imx6ul-14x14-evk.dts?h=imx/fixes&id=bf3251e112a0139c8dec796c9f12f2e8f01a73ca
