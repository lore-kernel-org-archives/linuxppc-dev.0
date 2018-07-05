Return-Path: <diana.craciun@nxp.com>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41LzCm36czzF1g4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 23:26:43 +1000 (AEST)
From: Diana Madalina Craciun <diana.craciun@nxp.com>
To: Michael Ellerman <mpe@ellerman.id.au>, =?iso-8859-1?Q?Michal_Such=E1nek?=
 <msuchanek@suse.de>, Bharat Bhushan <bharat.bhushan@nxp.com>
CC: "oss@buserror.net" <oss@buserror.net>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Leo Li <leoyang.li@nxp.com>
Subject: Re: [PATCH v2 3/3] powerpc/fsl: Implement cpu_show_spectre_v1/v2 for
 NXP PowerPC Book3E
Date: Thu, 5 Jul 2018 13:26:36 +0000
Message-ID: <VI1PR0401MB246338310F4EECEDEE6757A6FF400@VI1PR0401MB2463.eurprd04.prod.outlook.com>
References: <1528721608-15443-1-git-send-email-diana.craciun@nxp.com>
 <1528721608-15443-4-git-send-email-diana.craciun@nxp.com>
 <AM5PR0401MB2545BC30FB194E4D4E42ADA89A7F0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
 <20180612120737.31efff1c@naga.suse.cz>
 <87va9wg4qe.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/03/2018 10:26 AM, Michael Ellerman wrote:=0A=
> Michal Such=E1nek <msuchanek@suse.de> writes:=0A=
>> On Tue, 12 Jun 2018 02:59:11 +0000=0A=
>> Bharat Bhushan <bharat.bhushan@nxp.com> wrote:=0A=
>>=0A=
>>> Hi Diana,=0A=
>>>=0A=
>>>> -----Original Message-----=0A=
>>>> From: Diana Craciun [mailto:diana.craciun@nxp.com]=0A=
>>>> Sent: Monday, June 11, 2018 6:23 PM=0A=
>>>> To: linuxppc-dev@lists.ozlabs.org=0A=
>>>> Cc: mpe@ellerman.id.au; oss@buserror.net; Leo Li=0A=
>>>> <leoyang.li@nxp.com>; Bharat Bhushan <bharat.bhushan@nxp.com>;=0A=
>>>> Diana Madalina Craciun <diana.craciun@nxp.com>=0A=
>>>> Subject: [PATCH v2 3/3] powerpc/fsl: Implement=0A=
>>>> cpu_show_spectre_v1/v2 for NXP PowerPC Book3E  =0A=
>>> Please add some description=0A=
>> To me the subject is self-explanatory. It implements a kernel interface=
=0A=
>> that was already described elsewhere.=0A=
>>=0A=
>> What are you missing here?=0A=
> It should at least explain why it's reimplementing a function that=0A=
> already exists for powerpc. ie. Why can't the existing version be used?=
=0A=
>=0A=
> cheers=0A=
>=0A=
OK. I think I can use the cpu_show_spectre_v1 and for now I can use=0A=
cpu_show_spectre_v2 as well (the patches are under development for=0A=
mitigating Spectre v2). But I cannot use cpu_show_meltdown because it=0A=
uses references to variables that are specific to BOOK3S_64. But I do=0A=
not need a special implementation for cpu_show_meltdown because our=0A=
platform is not vulnerable to Meltdown. So, I will just ifdef the=0A=
cpu_show_meltdown and leave the default implementation.=0A=
=0A=
Diana=0A=
=0A=
=0A=
=0A=
=0A=
