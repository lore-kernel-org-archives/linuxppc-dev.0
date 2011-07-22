Return-Path: <B21989@freescale.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 86371B6F70
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jul 2011 12:15:58 +1000 (EST)
Received: from mail37-va3 (localhost.localdomain [127.0.0.1])	by
	mail37-va3-R.bigfish.com (Postfix) with ESMTP id DFBF1AE033F	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2011 02:15:53 +0000 (UTC)
Received: from VA3EHSMHS013.bigfish.com (unknown [10.7.14.235])	by
	mail37-va3.bigfish.com (Postfix) with ESMTP id 6B6CAFF8066	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2011 02:12:51 +0000 (UTC)
From: Xie Shaohui-B21989 <B21989@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: RE: [PATCH 1/4] powerpc/85xx: fix interrupt number of
	memory-controller for P4080
Date: Fri, 22 Jul 2011 02:12:44 +0000
Message-ID: <267A3B246C22C34A8E574051858E077010E111@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1311243889-4316-1-git-send-email-Shaohui.Xie@freescale.com>
	<CAOZdJXVL_iFPBb-D+c6UxLnvu7yqY3-yx5NQ8+SSAEQyaFdehQ@mail.gmail.com>
In-Reply-To: <CAOZdJXVL_iFPBb-D+c6UxLnvu7yqY3-yx5NQ8+SSAEQyaFdehQ@mail.gmail.com>
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

>From: Tabi Timur-B04825
>Sent: Thursday, July 21, 2011 11:58 PM
>To: Xie Shaohui-B21989
>Cc: linuxppc-dev@lists.ozlabs.org; Gala Kumar-B11780
>Subject: Re: [PATCH 1/4] powerpc/85xx: fix interrupt number of memory-
>controller for P4080
>
>On Thu, Jul 21, 2011 at 5:24 AM, Shaohui Xie <Shaohui.Xie@freescale.com>
>wrote:
>> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
>> ---
>
>Can you provide an explanation as to why the current numbers are wrong?
>

[Xie Shaohui] This irq number is used by edac/mc, the edac/mc will handle t=
he error interrupt
Issued by memory-controllers, but the error interrupt on p4080 is 16.


Best Regards,=20
Shaohui Xie
