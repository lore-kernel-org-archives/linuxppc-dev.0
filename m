Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7B967B70D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Jun 2009 02:54:10 +1000 (EST)
Received: from IE1EHSOBE002.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id A33DFDDDA2
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2009 02:54:09 +1000 (EST)
Message-ID: <4A4108A3.8060003@am.sony.com>
Date: Tue, 23 Jun 2009 09:53:55 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/ps3: Use pr_devel() in ps3/mm.c
References: <8977d21ed6cf59b89f9a830d59968ce178420a46.1245722192.git.michael@ellerman.id.au>
In-Reply-To: <8977d21ed6cf59b89f9a830d59968ce178420a46.1245722192.git.michael@ellerman.id.au>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/22/2009 06:56 PM, Michael Ellerman wrote:
> The non-debug case in ps3/mm.c uses pr_debug(), so that the compiler
> still does type checks etc. and doesn't complain about unused
> variables in the non-debug case.
> 
> However with DEBUG=n and CONFIG_DYNAMIC_DEBUG=y there's still code
> generated for those pr_debugs().
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
>  arch/powerpc/platforms/ps3/mm.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Looks good, thanks.  I put it on the todo list to go through
the the remaining PS3 code to check for the same.

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
