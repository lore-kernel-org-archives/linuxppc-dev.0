Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACCDC433EF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 May 2022 02:55:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L4pB413vnz3bmC
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 May 2022 12:55:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4L4p9T3XSWz3blZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2022 12:55:09 +1000 (AEST)
Received: from ip6-localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 24L2lVGD004361;
 Fri, 20 May 2022 21:47:32 -0500
Message-ID: <f84c4cb17eebe385fe22c3fc4563645742269d46.camel@kernel.crashing.org>
Subject: Re: [PATCH net-next] eth: de4x5: remove support for Generic DECchip
 & DIGITAL EtherWORKS PCI/EISA
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Date: Sat, 21 May 2022 12:47:31 +1000
In-Reply-To: <20220519031345.2134401-1-kuba@kernel.org>
References: <20220519031345.2134401-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: tsbogend@alpha.franken.de, linux-parisc@vger.kernel.org, arnd@arndb.de,
 corbet@lwn.net, netdev@vger.kernel.org, sburla@marvell.com,
 linux-doc@vger.kernel.org, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, edumazet@google.com, paulus@samba.org,
 vburru@marvell.com, zhangyue1@kylinos.cn, pabeni@redhat.com,
 aayarekar@marvell.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2022-05-18 at 20:13 -0700, Jakub Kicinski wrote:
> Looks like almost all changes to this driver had been tree-wide
> refactoring since git era begun. There is one commit from Al
> 15 years ago which could potentially be fixing a real bug.
> 
> The driver is using virt_to_bus() and is a real magnet for pointless
> cleanups. It seems unlikely to have real users. Let's try to shed
> this maintenance burden.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Removing this driver will kill support for some rather old PowerMac
models (some PowerBooks I think, paulus would know). No objection on my
part, though. I doubt people still use these things with new kernels
but ... who knows ? :-)

Cheers,
Ben.

