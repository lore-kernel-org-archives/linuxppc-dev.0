Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0206.outbound.protection.outlook.com [207.46.163.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 45F922C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Dec 2013 14:03:22 +1100 (EST)
Message-ID: <1387335782.3140.11.camel@snotra.buserror.net>
Subject: Re: [v3][PATCH 1/8] powerpc/book3e: rename interrupt_end_book3e
 with __end_interrupts
From: Scott Wood <scottwood@freescale.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
Date: Tue, 17 Dec 2013 21:03:02 -0600
In-Reply-To: <1373357007-30785-2-git-send-email-tiejun.chen@windriver.com>
References: <1373357007-30785-1-git-send-email-tiejun.chen@windriver.com>
 <1373357007-30785-2-git-send-email-tiejun.chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-07-09 at 16:03 +0800, Tiejun Chen wrote:
> We can rename 'interrupt_end_book3e' with '__end_interrupts' then
> book3s/book3e can share this unique label to make sure we can use
> this conveniently.
> 
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>

What users of this do you plan to share between book3s and book3e?  I'm
not seeing any existing book3s users that are obviously applicable to
book3e -- they mainly involve copying exception vectors which we
shouldn't need to do.

-Scott
