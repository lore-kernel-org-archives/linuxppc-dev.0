Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
 [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id BB614B6F74
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 08:03:48 +1100 (EST)
Received: from mail108-db3 (localhost [127.0.0.1])	by
 mail108-db3-R.bigfish.com (Postfix) with ESMTP id 309F77005EB	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jan 2012 21:03:31 +0000 (UTC)
Received: from DB3EHSMHS017.bigfish.com (unknown [10.3.81.246])	by
 mail108-db3.bigfish.com (Postfix) with ESMTP id 12EC0600043	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jan 2012 21:03:31 +0000 (UTC)
Message-ID: <4F0B561A.7060903@freescale.com>
Date: Mon, 9 Jan 2012 15:03:22 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: <b29983@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: Add P1024rdb dts support
References: <1326098258-32097-1-git-send-email-b29983@freescale.com>
In-Reply-To: <1326098258-32097-1-git-send-email-b29983@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Tang Yuantian <Yuantian.Tang@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/09/2012 02:37 AM, b29983@freescale.com wrote:
> +/include/ "p1024rdb.dtsi"
> +/include/ "fsl/p1020si-post.dtsi"

Is p1024 100% software-compatible with p1020?

They have different manuals...

-Scott
