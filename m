Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 82D782C0090
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2012 00:31:55 +1000 (EST)
Subject: Re: [PATCH] powerpc/fsl: mpic timer driver
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259DA4580@039-SN2MPN1-021.039d.mgd.msft.net>
Date: Tue, 31 Jul 2012 09:31:04 -0500
Message-Id: <267909D0-5FDC-4864-AA4B-189A651889A6@kernel.crashing.org>
References: <1343370058-2983-1-git-send-email-Dongsheng.wang@freescale.com>
 <2F4F76E5-1ACD-4F30-A997-9811DCE82202@kernel.crashing.org>
 <ABB05CD9C9F68C46A5CEDC7F15439259DA4580@039-SN2MPN1-021.039d.mgd.msft.net>
To: Wang Dongsheng-B40534 <B40534@freescale.com>
Cc: "paulus@samba.org" <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Wood Scott-B07421 <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 31, 2012, at 2:58 AM, Wang Dongsheng-B40534 wrote:

>=20
>=20
>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Friday, July 27, 2012 9:14 PM
>> To: Wang Dongsheng-B40534
>> Cc: benh@kernel.crashing.org; paulus@samba.org; Wood Scott-B07421;
>> linuxppc-dev@lists.ozlabs.org
>> Subject: Re: [PATCH] powerpc/fsl: mpic timer driver
>>=20
>>=20
>> On Jul 27, 2012, at 1:20 AM, <Dongsheng.wang@freescale.com>
>> <Dongsheng.wang@freescale.com> wrote:
>>=20
>>> From: Wang Dongsheng <Dongsheng.Wang@freescale.com>
>>>=20
>>> Global timers A and B internal to the PIC. The two independent =
groups
>>> of global timer, group A and group B, are identical in their
>> functionality.
>>> The hardware timer generates an interrupt on every timer cycle.
>>> e.g
>>> Power management can use the hardware timer to wake up the machine.
>>>=20
>>> Signed-off-by: Wang Dongsheng <Dongsheng.Wang@freescale.com>
>>> Signed-off-by: Li Yang <leoli@freescale.com>
>>=20
>> How much of this is FSL specific vs openpic?  OpenPIC spec's timer
>> support (only a single group).
>>=20
> [Wang Dongsheng] Yes, OpenPIC only a single group timer.
> FSL: add more register, features and group.
> This patch only to support FSL chip.
> "mpic_timer.c" -> "fsl_mpic_timer.c"
> I will modify the description of the patch. how about?

I'd rather we support both, can we not use the MPIC_FSL flag to deal =
with FSL specific behavior?

- k
