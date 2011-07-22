Return-Path: <B21989@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8129EB6F70
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jul 2011 12:56:42 +1000 (EST)
Received: from mail131-tx2 (localhost.localdomain [127.0.0.1])	by
	mail131-tx2-R.bigfish.com (Postfix) with ESMTP id 5B7DD848280	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2011 02:56:33 +0000 (UTC)
Received: from TX2EHSMHS012.bigfish.com (unknown [10.9.14.252])	by
	mail131-tx2.bigfish.com (Postfix) with ESMTP id 42CEB12C804C	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2011 02:56:33 +0000 (UTC)
From: Xie Shaohui-B21989 <B21989@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: RE: [PATCH 3/4] powerpc/85xx: Merge PCI/PCI Express error
	management registers
Date: Fri, 22 Jul 2011 02:56:29 +0000
Message-ID: <267A3B246C22C34A8E574051858E077010E12B@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1311244195-4418-1-git-send-email-Shaohui.Xie@freescale.com>
	<CAOZdJXVFakNCpQk6CPB_V7WVtkfREwuUMqs31XfjuKZnc3-ARA@mail.gmail.com>
In-Reply-To: <CAOZdJXVFakNCpQk6CPB_V7WVtkfREwuUMqs31XfjuKZnc3-ARA@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Gala Kumar-B11780 <B11780@freescale.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Jiang Kai-B18973 <B18973@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From: Tabi Timur-B04825
>Sent: Thursday, July 21, 2011 11:59 PM
>To: Xie Shaohui-B21989
>Cc: linuxppc-dev@lists.ozlabs.org; Gala Kumar-B11780; Jiang Kai-B18973
>Subject: Re: [PATCH 3/4] powerpc/85xx: Merge PCI/PCI Express error
>management registers
>
>On Thu, Jul 21, 2011 at 5:29 AM, Shaohui Xie <Shaohui.Xie@freescale.com>
>wrote:
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 /* - PCIE has no this register
>*/
>
>I don't understand this sentence.
>

[Xie Shaohui] this patch intend to merge PCI and PCIe error management regi=
sters into a unit
Structure, some register offsets where PCI has definitions while PCIe are r=
eserved. For ex. On
MPC8536, PCI has a register ERR_CAP_DR (PCI error capture disabled register=
) at offset 0xe04,=20
But this offset is reserved in PCIe.



Best Regards,=20
Shaohui Xie
