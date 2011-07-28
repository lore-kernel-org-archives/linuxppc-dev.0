Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 92A42B6F64
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Jul 2011 05:57:03 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [RFC PATCH] powerpc: 85xx: Make e500/e500v2 depend on !E500MC
Date: Thu, 28 Jul 2011 19:56:53 +0000
Message-ID: <CAOZdJXVsJUrCaNVHjhLkL=-GwAr79S9xQdoRLvjFG--k1jdRvw@mail.gmail.com>
References: <fef1cfc9a418ec5aa3302915dcb392882f7dd5d2.1308545584.git.baruch@tkos.co.il>
In-Reply-To: <fef1cfc9a418ec5aa3302915dcb392882f7dd5d2.1308545584.git.baruch@tkos.co.il>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Gala Kumar-B11780 <B11780@freescale.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 19, 2011 at 11:56 PM, Baruch Siach <baruch@tkos.co.il> wrote:
> CONFIG_E500MC breaks e500/e500v2 systems. It defines L1_CACHE_SHIFT to 6,=
 thus
> breaking clear_pages(), probably others too.
>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> Is this the right approach?

It doesn't work for me.

I need something that if an e500v2 platform (e.g. the P1022DS) is
selected, then I won't be able to select any e500mc platforms (e.g.
P4080DS).  And if I don't select any e500v2 platforms, then I will be
able to select an e500mc platform.  This patch doesn't seem to do
that.

It might be necessary to split the entire menu into two parts, one for
e500v2 parts and one for e500mc parts.

--=20
Timur Tabi
Linux kernel developer at Freescale=
