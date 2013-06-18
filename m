Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5B35B2C008A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 10:21:05 +1000 (EST)
Received: from mail105-ch1 (localhost [127.0.0.1])	by
 mail105-ch1-R.bigfish.com (Postfix) with ESMTP id A1FBD1002A8	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 00:21:01 +0000 (UTC)
Received: from CH1EHSMHS027.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.230])	by mail105-ch1.bigfish.com (Postfix) with ESMTP id
 32C543E0061	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 00:20:59
 +0000 (UTC)
Date: Mon, 17 Jun 2013 19:18:44 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/5] powerpc/dts: add MPIC v4.3 dts node
To: Lian Minghuan-b31939 <B31939@freescale.com>
References: <1371194159-17332-1-git-send-email-Minghuan.Lian@freescale.com>
 <1371242366.2996.10@snotra> <1371246799.2996.14@snotra>
 <51BE7329.8070304@freescale.com>
In-Reply-To: <51BE7329.8070304@freescale.com> (from B31939@freescale.com on
 Sun Jun 16 21:23:37 2013)
Message-ID: <1371514724.9073.13@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/16/2013 09:23:37 PM, Lian Minghuan-b31939 wrote:
> Hi Scott,
>=20
> please see my comments.
>=20
> On 06/15/2013 05:53 AM, Scott Wood wrote:
>> On 06/14/2013 03:39:26 PM, Scott Wood wrote:
>>> On 06/14/2013 02:15:55 AM, Minghuan Lian wrote:
>>>> +msi0: msi@41600 {
>>>> +    compatible =3D "fsl,mpic-msi", "fsl,mpic-msi-v4.3";
>>>=20
>>> More specific compatibles come first -- and I don't think this is =20
>>> 100% backwards compatible with "fsl,mpic-msi" anyway.
>>=20
>> Also please update the binding.
> [Minghuan] Yes, maybe I should remove "fsl,mpic-msi". What do you =20
> think?

Yes.

-Scott=
