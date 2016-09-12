Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0050.hostedemail.com
 [216.40.44.50])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXtpZ600szDsXs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 02:40:38 +1000 (AEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave05.hostedemail.com (Postfix) with ESMTP id 8739E1845E7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 16:34:38 +0000 (UTC)
Message-ID: <1473698067.11006.10.camel@perches.com>
Subject: Re: [PATCH] powerpc/32: add missing \n at end of printk warning
 message
From: Joe Perches <joe@perches.com>
To: Colin King <colin.king@canonical.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Date: Mon, 12 Sep 2016 09:34:27 -0700
In-Reply-To: <20160912101224.24877-1-colin.king@canonical.com>
References: <20160912101224.24877-1-colin.king@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-09-12 at 11:12 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> The message is missing a \n, add it.

Was this found via inspection or a tool?
