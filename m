Return-Path: <B11780@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
	[213.199.154.205])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4BD93B6F7B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 31 Aug 2011 13:20:13 +1000 (EST)
Received: from mail51-am1 (localhost.localdomain [127.0.0.1])	by
	mail51-am1-R.bigfish.com (Postfix) with ESMTP id 4C79C9182A6	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2011 03:20:07 +0000 (UTC)
Received: from AM1EHSMHS008.bigfish.com (unknown [10.3.201.247])	by
	mail51-am1.bigfish.com (Postfix) with ESMTP id A0D6718600DA	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2011 03:18:44 +0000 (UTC)
Subject: Re: [PATCH] powerpc/p1023rds: Fix the error of bank-width of nor flash
MIME-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1313146809-13686-1-git-send-email-Chunhe.Lan@freescale.com>
Date: Tue, 30 Aug 2011 22:18:42 -0500
Message-ID: <28BF0640-0199-4A4F-B335-582650291893@freescale.com>
References: <1313146809-13686-1-git-send-email-Chunhe.Lan@freescale.com>
To: Chunhe Lan <Chunhe.Lan@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 12, 2011, at 6:00 AM, Chunhe Lan wrote:

> In the p1023rds, a physical bus of nor flash is 16 bits width.
> The bank-width is width (in bytes) of the bus width. So, the
> value of bank-width of nor flash is not one, and it should be
> two.
> 
> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> ---
> arch/powerpc/boot/dts/p1023rds.dts |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

applied to merge

- k
