Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLbVp3grQzDrfj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 20:37:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Qiang Zhao <qiang.zhao@nxp.com>, "oss\@buserror.net" <oss@buserror.net>
Cc: "valentin.longchamp\@keymile.com" <valentin.longchamp@keymile.com>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] qe: fix compile issue for arm64
In-Reply-To: <AM3PR04MB118514C540F2A3FF383FC4AD91BF0@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <1500867555-36277-1-git-send-email-qiang.zhao@nxp.com>
 <87o9s5dr6n.fsf@concordia.ellerman.id.au>
 <AM3PR04MB118514C540F2A3FF383FC4AD91BF0@AM3PR04MB1185.eurprd04.prod.outlook.com>
Date: Mon, 31 Jul 2017 20:37:21 +1000
Message-ID: <877eyo6gf2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Qiang Zhao <qiang.zhao@nxp.com> writes:

> Fri 7/28/2017 2:14 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> -----Original Message-----
>> From: Michael Ellerman [mailto:mpe@ellerman.id.au]
>> Sent: Friday, July 28, 2017 2:14 PM
>> To: Qiang Zhao <qiang.zhao@nxp.com>; oss@buserror.net
>> Cc: valentin.longchamp@keymile.com; linuxppc-dev@lists.ozlabs.org; linux-
>> kernel@vger.kernel.org; Qiang Zhao <qiang.zhao@nxp.com>
>> Subject: Re: [PATCH v2] qe: fix compile issue for arm64
>> 
>> Zhao Qiang <qiang.zhao@nxp.com> writes:
>> 
>> > Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
>> > ---
>> > Changes for v2:
>> > 	- include all Errata QE_General4 in #ifdef
>> >
>> >  drivers/soc/fsl/qe/qe.c | 2 ++
>> >  1 file changed, 2 insertions(+)
>> 
>> AFAICS this driver can only be built on PPC, what am I missing?
>> 
>> config QUICC_ENGINE
>>         bool "Freescale QUICC Engine (QE) Support"
>>         depends on FSL_SOC && PPC32
>> 
>> cheers
>
> I sent another patchset to support it on arm64.

Where? I don't see it.

Shouldn't this patch be part of that series? Otherwise when that series
is merged the build will break on arm64.

cheers
