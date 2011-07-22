Return-Path: <B21989@freescale.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
	[213.199.154.140])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 32FA1B6F71
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jul 2011 16:23:37 +1000 (EST)
From: Xie Shaohui-B21989 <B21989@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 1/4] powerpc/85xx: fix interrupt number of
	memory-controller for P4080
Date: Fri, 22 Jul 2011 06:22:59 +0000
Message-ID: <267A3B246C22C34A8E574051858E077010E1BE@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1311243889-4316-1-git-send-email-Shaohui.Xie@freescale.com>
	<65C49D37-A103-494D-AD8E-7C8FC6E3716E@freescale.com>
	<267A3B246C22C34A8E574051858E077010E0F7@039-SN1MPN1-003.039d.mgd.msft.net>
	<D1A417CC-2514-4103-8D0E-96F16724BCEF@kernel.crashing.org>
In-Reply-To: <D1A417CC-2514-4103-8D0E-96F16724BCEF@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Gala Kumar-B11780 <B11780@freescale.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


=20


>-----Original Message-----
>From: Kumar Gala [mailto:galak@kernel.crashing.org]
>Sent: Friday, July 22, 2011 2:01 PM
>To: Xie Shaohui-B21989
>Cc: Gala Kumar-B11780; linuxppc-dev@lists.ozlabs.org
>Subject: Re: [PATCH 1/4] powerpc/85xx: fix interrupt number of memory-
>controller for P4080
>
>
>On Jul 21, 2011, at 9:04 PM, Xie Shaohui-B21989 wrote:
>
>>
>>
>>
>>> -----Original Message-----
>>> From: Gala Kumar-B11780
>>> Sent: Thursday, July 21, 2011 8:13 PM
>>> To: Xie Shaohui-B21989
>>> Cc: linuxppc-dev@lists.ozlabs.org
>>> Subject: Re: [PATCH 1/4] powerpc/85xx: fix interrupt number of
>>> memory- controller for P4080
>>>
>>>
>>> On Jul 21, 2011, at 5:24 AM, Shaohui Xie wrote:
>>>
>>>> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
>>>> ---
>>>> arch/powerpc/boot/dts/p4080ds.dts |    4 ++--
>>>> 1 files changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/boot/dts/p4080ds.dts
>>> b/arch/powerpc/boot/dts/p4080ds.dts
>>>> index 927f94d..9c37a85 100644
>>>> --- a/arch/powerpc/boot/dts/p4080ds.dts
>>>> +++ b/arch/powerpc/boot/dts/p4080ds.dts
>>>> @@ -131,14 +131,14 @@
>>>> 			compatible =3D "fsl,p4080-memory-controller";
>>>> 			reg =3D <0x8000 0x1000>;
>>>> 			interrupt-parent =3D <&mpic>;
>>>> -			interrupts =3D <0x12 2>;
>>>> +			interrupts =3D <16 2>;
>>>> 		};
>>>>
>>>> 		memory-controller@9000 {
>>>> 			compatible =3D "fsl,p4080-memory-controller";
>>>> 			reg =3D <0x9000 0x1000>;
>>>> 			interrupt-parent =3D <&mpic>;
>>>> -			interrupts =3D <0x12 2>;
>>>> +			interrupts =3D <16 2>;
>>>> 		};
>>>>
>>>> 		corenet-cf@18000 {
>>>> --
>>>> 1.6.4
>>>
>>> What code base / tree is this against?
>>>
>>
>> [Xie Shaohui] This patch is based on v3.0-rc7.
>
>Please use galak/powerpc.git 'next' branch.
>
>It has the following:
>
>http://git.kernel.org/?p=3Dlinux/kernel/git/galak/powerpc.git;a=3Dblob;f=
=3Darch/
>powerpc/boot/dts/p4080si.dtsi;h=3Db71051f506c1763fbb911a0df62b58577eda2ce0=
;h
>b=3Drefs/heads/next
>

[Xie Shaohui] OK, thanks!
I'll rebase these patches on 'next' branch.



Best Regards,=20
Shaohui Xie
