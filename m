Return-Path: <hollis@penguinppc.org>
Received: from fall-curlleaf.atl.sa.earthlink.net
	(fall-curlleaf.atl.sa.earthlink.net [207.69.195.105])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AFD8368A42
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jan 2006 03:03:29 +1100 (EST)
Received: from pop-savannah.atl.sa.earthlink.net ([207.69.195.69])
	by fall-curlleaf.atl.sa.earthlink.net with esmtp (Exim 4.34)
	id 1EyWee-00016J-HM
	for linuxppc-dev@ozlabs.org; Mon, 16 Jan 2006 10:52:24 -0500
Subject: Re: [PATCH] drop linuxppc64-dev
From: Hollis Blanchard <hollis@penguinppc.org>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20060116121244.GB7171@suse.de>
References: <20060116121244.GB7171@suse.de>
Content-Type: text/plain
Date: Mon, 16 Jan 2006 09:52:11 -0600
Message-Id: <1137426731.22151.8.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-01-16 at 13:12 +0100, Olaf Hering wrote:
> Everything is merged into arch/powerpc now.
> Stop cross-posting.

> --- linux-2.6.15-olh.orig/MAINTAINERS
> +++ linux-2.6.15-olh/MAINTAINERS
> @@ -527,7 +527,7 @@ S:   Supported
>  BROADBAND PROCESSOR ARCHITECTURE
>  P:     Arnd Bergmann
>  M:     arnd@arndb.de
> -L:     linuxppc64-dev@ozlabs.org
> +L:     linuxppc-dev@ozlabs.org
>  W:     http://linuxppc64.org
>  S:     Supported

Are you suggesting that nobody should ever use linuxppc64-dev now? If
so, patching MAINTAINERS doesn't seem like the right way to enforce
that.

Do we want to think about merging the mailing lists? Both seem fairly
high-volume right now (compare
http://ozlabs.org/pipermail/linuxppc64-dev/ and
http://ozlabs.org/pipermail/linuxppc-dev/). linuxppc-embedded is
separate. There are certainly lots of emails and patches that are common
to both 32- and 64-bit, though...

The subscriber lists don't overlap 100%, but the difference might be
small enough not to matter to many people.

-Hollis
