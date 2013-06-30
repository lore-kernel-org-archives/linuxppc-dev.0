Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C62782C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jul 2013 02:23:16 +1000 (EST)
Date: Sun, 30 Jun 2013 18:23:00 +0200
From: Gerhard Sittig <gsi@denx.de>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] powerpc/mpc512x: update defconfig
Message-ID: <20130630162300.GC24305@book.gsilab.sittig.org>
References: <1372142237-20554-1-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1372142237-20554-1-git-send-email-agust@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 25, 2013 at 08:37 +0200, Anatolij Gustschin wrote:
> 
> From: Gerhard Sittig <gsi@denx.de>
> 
> This patch does not change the content, it merely re-orders
> configuration items and drops explicit options which already
> apply as the default.
> 
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>

In hindsight, I'd prefer to reword the subject to something more
specific, unless it's too late for this now.  I suggest:

  [PATCH] powerpc/mpc512x: commit re-generated defconfig

But if the patch is already queued somewhere, or is acceptable
with the more generic subject, that's fine with me as well.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
