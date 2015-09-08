Return-Path: <geoff@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 95C731A1F45
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2015 03:04:19 +1000 (AEST)
Message-ID: <1441731854.13198.8.camel@infradead.org>
Subject: Re: [PATCH] powerpc: Kconfig: remove BE-only platforms from LE
 kernel build
From: Geoff Levand <geoff@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Arnd
 Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>, Olof Johansson <olof@lixom.net>
Date: Tue, 08 Sep 2015 10:04:14 -0700
In-Reply-To: <1441583880-17824-1-git-send-email-boqun.feng@gmail.com>
References: <1441583880-17824-1-git-send-email-boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-09-07 at 07:58 +0800, Boqun Feng wrote:

>  arch/powerpc/platforms/ps3/Kconfig      | 2 +-

Looks OK for PS3.

Acked-by: Geoff Levand <geoff@infradead.org>
