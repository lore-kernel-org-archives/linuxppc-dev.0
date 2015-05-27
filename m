Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0147.outbound.protection.outlook.com [207.46.100.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EAAE01A0661
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 03:37:08 +1000 (AEST)
Message-ID: <1432748213.4089.23.camel@freescale.com>
Subject: Re: [PATCH 2/2] rheap: move rheap.c from arch/powerpc/lib/ to lib/
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang <B45475@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <B07421@freescale.com>,
 <R63061@freescale.com>
Date: Wed, 27 May 2015 12:36:53 -0500
In-Reply-To: <1432717920-43563-2-git-send-email-B45475@freescale.com>
References: <1432717920-43563-1-git-send-email-B45475@freescale.com>
 <1432717920-43563-2-git-send-email-B45475@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-05-27 at 17:12 +0800, Zhao Qiang wrote:
> qe need to use the rheap, so move it to public directory.

You've been previously asked to use lib/genalloc.c rather than 
introduce duplicate functionality into /lib.  NACK.

Also, please don't use coreid-based e-mail addresses with no real 
names associated, which makes it hard to tell who has been CCed.

-Scott
