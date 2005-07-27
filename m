Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C811267DA7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jul 2005 05:58:54 +1000 (EST)
Date: Wed, 27 Jul 2005 12:57:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kumar Gala <galak@freescale.com>
Message-Id: <20050727125746.54329281.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0507271029480.12237@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0507271029480.12237@nylon.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 00/14] ppc32: Remove board ports that are no longer
 maintained
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar Gala <galak@freescale.com> wrote:
>
> The following board ports are no longer maintained or have become 
>  obsolete:
> 
>  adir
>  ash
>  beech
>  cedar
>  ep405
>  k2
>  mcpn765
>  menf1
>  oak
>  pcore
>  rainier
>  redwood
>  sm850
>  spd823ts
> 
>  We are there for removing support for them.

I'll merge all these into -mm for now, but will hold off sending any of
them upstream pending confirmation of which patches we really want to
proceed with.
