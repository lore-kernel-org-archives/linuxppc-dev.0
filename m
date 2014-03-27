Return-Path: <Jason.Jin@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0238.outbound.protection.outlook.com [207.46.163.238])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44023140084
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 14:38:44 +1100 (EST)
From: "Jason.Jin@freescale.com" <Jason.Jin@freescale.com>
To: Timur Tabi <timur@tabi.org>
Subject: RE: [PATCH 1/2] video/fsl: make the diu driver work without
 platform hooks
Date: Thu, 27 Mar 2014 03:38:37 +0000
Message-ID: <4d5b5f023d564c738e7c8e4e05571b1a@BLUPR03MB373.namprd03.prod.outlook.com>
References: <1395855704-19908-1-git-send-email-Jason.Jin@freescale.com>
 <533320A0.8010507@tabi.org>
 <f6883c3f759a4544936acec5dc7e542b@BLUPR03MB373.namprd03.prod.outlook.com>
 <53339C96.3070406@tabi.org>
In-Reply-To: <53339C96.3070406@tabi.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Jason.Jin@freescale.com wrote:
> >>>>> However, the DIU is already initialized in u-boot and we can rely
> >>>>> on the settings in u-boot for corenet platform,
> >>>
> >>> I don't like that at all.
> > [Jason Jin-R64188] What's the potential issue of this? Most of the IPs
> > need the platform initialization in u-boot. For example, the hwconfig
> > in u-boot used for board specific settings for most platform.
>=20
> The potential problem is that it's not stable.  Power management breaks
> your code.
>=20
> I won't NACK your patch, but it feels like a band-aid rather than a real
> solution.
>=20
[Jason Jin-R64188] Thanks. The power management will break the pixel clock =
only. We can try to fix it separately. I'll try to explain it in that mail.
