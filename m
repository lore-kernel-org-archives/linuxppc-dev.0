Return-Path: <geoff@infradead.org>
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 606BC1A06F9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2015 03:20:34 +1000 (AEST)
Message-ID: <1441128024.29534.32.camel@infradead.org>
Subject: Re: [PATCH] ps3-vuart: BUG_ON on null drv before dereferencing it
 on dev_dbg
From: Geoff Levand <geoff@infradead.org>
To: Colin King <colin.king@canonical.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Tue, 01 Sep 2015 10:20:24 -0700
In-Reply-To: <1441102876-26978-1-git-send-email-colin.king@canonical.com>
References: <1441102876-26978-1-git-send-email-colin.king@canonical.com>
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

On Tue, 2015-09-01 at 11:21 +0100, Colin King wrote:
> On the unlikely event that drv is null, the current code will
> perform a null pointer dereference with it when printing a dev_dbg
> message.  Instead, the BUG_ON check on drv should be performed
> before we emit the dev_dbg message.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

I applied this to my ps3-linux repo.  I can update it if you decide to
do the other fixes Geert mentioned.

-Geoff
