Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A8B3C2C009A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 07:53:32 +1000 (EST)
Received: from mail194-co9 (localhost [127.0.0.1])	by
 mail194-co9-R.bigfish.com (Postfix) with ESMTP id CF1B21C0084	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 21:53:27 +0000 (UTC)
Received: from CO9EHSMHS009.bigfish.com (unknown [10.236.132.236])	by
 mail194-co9.bigfish.com (Postfix) with ESMTP id C34DF380051	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 21:53:24 +0000 (UTC)
Date: Fri, 14 Jun 2013 16:53:19 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/5] powerpc/dts: add MPIC v4.3 dts node
To: Scott Wood <scottwood@freescale.com>
References: <1371194159-17332-1-git-send-email-Minghuan.Lian@freescale.com>
 <1371242366.2996.10@snotra>
In-Reply-To: <1371242366.2996.10@snotra> (from scottwood@freescale.com on
 Fri Jun 14 15:39:26 2013)
Message-ID: <1371246799.2996.14@snotra>
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

On 06/14/2013 03:39:26 PM, Scott Wood wrote:
> On 06/14/2013 02:15:55 AM, Minghuan Lian wrote:
>> +msi0: msi@41600 {
>> +	compatible =3D "fsl,mpic-msi", "fsl,mpic-msi-v4.3";
>=20
> More specific compatibles come first -- and I don't think this is =20
> 100% backwards compatible with "fsl,mpic-msi" anyway.

Also please update the binding.

-Scott=
