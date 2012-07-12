Return-Path: <B04825@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4E0F32C0200
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 13:53:32 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc/85xx: Create dts of each core in CAMP mode
 for P1021RDB-PC
Date: Thu, 12 Jul 2012 03:53:13 +0000
Message-ID: <4FFE4A28.2020405@freescale.com>
References: <1341909561-6591-1-git-send-email-Jiucheng.Xu@freescale.com>
 <1341909561-6591-2-git-send-email-Jiucheng.Xu@freescale.com>
 <CAOZdJXX1+=p3GMccLvCwFpei2igidXuo_U1gSVy56cBAkKxoHg@mail.gmail.com>
 <4D91E39B-2773-429D-B956-38C04521C8B2@kernel.crashing.org>
 <4FFD9281.1070202@freescale.com>
 <21405BDD-2124-4CB6-A947-0B8124D51063@kernel.crashing.org>
 <4FFD9439.2010901@freescale.com>
 <67BB61E8-A581-4863-A8B7-3A793E0225EE@kernel.crashing.org>
In-Reply-To: <67BB61E8-A581-4863-A8B7-3A793E0225EE@kernel.crashing.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: McClintock Matthew-B29882 <B29882@freescale.com>,
 Xu Jiucheng-B37781 <B37781@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>> >
>> >./p2020rdb_camp_core1.dts
>> >./p1020rdb-pc_camp_core1.dts
>> >./mpc8572ds_camp_core1.dts
>> >./p2020rdb_camp_core0.dts
>> >./p1020rdb-pc_camp_core0.dts
>> >./mpc8572ds_camp_core0.dts
>> >./p1020rdb_camp_core1.dts
>> >./p1020rdb_camp_core0.dts
>> >
> I'd be ok if we want to drop the p1020rdb as that board has been replaced=
 w/the p1020rdb-pc.

How about dropping the P2020RDB as well?  Then we have only two examples:=20
MPC8572DS and P1020RDB-PC.

--=20
Timur Tabi
Linux kernel developer at Freescale
