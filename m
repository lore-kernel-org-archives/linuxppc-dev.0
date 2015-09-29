Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0121.outbound.protection.outlook.com [65.55.169.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 21DF11A01EA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 10:23:29 +1000 (AEST)
Date: Mon, 28 Sep 2015 19:23:03 -0500
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 20/25] powerpc32: Remove clear_pages() and define
 clear_page() inline
Message-ID: <20150929002303.GI6161@home.buserror.net>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
 <9dcad7b2c05a397a97cc1cab211b6cf0f09a9900.1442939410.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <9dcad7b2c05a397a97cc1cab211b6cf0f09a9900.1442939410.git.christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 22, 2015 at 06:51:09PM +0200, Christophe Leroy wrote:
> clear_pages() is never used, and PPC32 is the only architecture
> (still) having this function. Neither PPC64 nor any other
> architecture has it.

It is used, by clear_page().

> This patch removes clear_page() and move clear_page() function
> inline (same as PPC64) as it only is a few isns

It removes clear_pages(), not clear_page().

-Scott
