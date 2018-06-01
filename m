Return-Path: <diana.craciun@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0067.outbound.protection.outlook.com [104.47.2.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40y6s26hdXzDrpC
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 00:58:14 +1000 (AEST)
From: Diana Madalina Craciun <diana.craciun@nxp.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC: Leo Li <leoyang.li@nxp.com>
Subject: Re: [RFC PATCH] powerpc/fsl: Add barrier_nospec implementation for
 NXP PowerPC Book E
Date: Fri, 1 Jun 2018 14:58:07 +0000
Message-ID: <VI1PR0401MB2463DDC6B6E08DB063884294FF620@VI1PR0401MB2463.eurprd04.prod.outlook.com>
References: <1526973031-9543-1-git-send-email-diana.craciun@nxp.com>
 <1527020969.30674.13.camel@buserror.net>
 <VI1PR0401MB246345AD11EC8666B7187F8DFF6D0@VI1PR0401MB2463.eurprd04.prod.outlook.com>
 <1527621245.30674.30.camel@buserror.net>
 <87wovjykh8.fsf@concordia.ellerman.id.au>
 <VI1PR0401MB2463C17743BC5C25C2152631FF630@VI1PR0401MB2463.eurprd04.prod.outlook.com>
 <1527804215.30674.35.camel@buserror.net>
 <87vab23i44.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 6/1/2018 1:40 PM, Michael Ellerman wrote:=0A=
> Scott Wood <oss@buserror.net> writes:=0A=
>=0A=
>> On Thu, 2018-05-31 at 14:35 +0000, Diana Madalina Craciun wrote:=0A=
>>> On 5/31/2018 5:21 PM, Michael Ellerman wrote:=0A=
>>>> We can add a nospectre_v1 command line option if necessary.=0A=
>>> What about nobarrier_nospec (or similar) instead of nospectre_v1 comman=
d=0A=
>>> line? We are not disabling all the v1 mitigations, the masking part wil=
l=0A=
>>> remain unchanged.=0A=
>> I think nospectre_v1 makes more sense as it's about the user's intention=
s=0A=
>> rather than the implementation.  The user is giving the kernel permissio=
n to=0A=
>> not defend against spectre v1, and it's up to the implementation which=
=0A=
>> mitigations (if any) to disable in response to that, same as any other=
=0A=
>> optimization.=0A=
> Yeah I agree. We also have `nospectre_v2` on x86/s390 so I think keeping=
=0A=
> consistency with that is a must.=0A=
>=0A=
> cheers=0A=
>=0A=
OK=0A=
=0A=
Diana=0A=
=0A=
