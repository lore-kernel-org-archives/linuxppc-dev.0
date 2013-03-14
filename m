Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (he.sipsolutions.net [78.46.109.217])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A06382C009B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2013 19:38:03 +1100 (EST)
Message-ID: <1363250273.4833.1.camel@jlt4.sipsolutions.net>
Subject: Re: [PATCH] powerpc: add Book E support to 64-bit hibernation
From: Johannes Berg <johannes@sipsolutions.net>
To: Wang Dongsheng <dongsheng.wang@freescale.com>
Date: Thu, 14 Mar 2013 10:37:53 +0200
In-Reply-To: <1363232178-29938-1-git-send-email-dongsheng.wang@freescale.com>
References: <1363232178-29938-1-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-03-14 at 11:36 +0800, Wang Dongsheng wrote:

> +#ifdef CONFIG_PPC_BOOK3S_64
>  	/* can't use RESTORE_SPECIAL(MSR) */
>  	ld	r0, SL_MSR(r11)
>  	mtmsrd	r0, 0

Unfortunately, I forgot the reason for this comment, and didn't put a
better one (almost 6 years ago!!)

> +	RESTORE_SPECIAL(MSR)

but maybe you also can't do this on BookE?

johannes
