Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0766CB6F74
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jul 2011 01:57:50 +1000 (EST)
Received: from mail61-va3 (localhost.localdomain [127.0.0.1])	by
	mail61-va3-R.bigfish.com (Postfix) with ESMTP id 4BB5A1B80B1	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2011 15:57:45 +0000 (UTC)
Received: from VA3EHSMHS025.bigfish.com (unknown [10.7.14.246])	by
	mail61-va3.bigfish.com (Postfix) with ESMTP id 18543D6804F	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2011 15:57:45 +0000 (UTC)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Xie Shaohui-B21989 <B21989@freescale.com>
Subject: Re: [PATCH 1/4] powerpc/85xx: fix interrupt number of
	memory-controller for P4080
Date: Thu, 21 Jul 2011 15:57:33 +0000
Message-ID: <CAOZdJXVL_iFPBb-D+c6UxLnvu7yqY3-yx5NQ8+SSAEQyaFdehQ@mail.gmail.com>
References: <1311243889-4316-1-git-send-email-Shaohui.Xie@freescale.com>
In-Reply-To: <1311243889-4316-1-git-send-email-Shaohui.Xie@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
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

On Thu, Jul 21, 2011 at 5:24 AM, Shaohui Xie <Shaohui.Xie@freescale.com> wr=
ote:
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> ---

Can you provide an explanation as to why the current numbers are wrong?

--=20
Timur Tabi
Linux kernel developer at Freescale=
