Return-Path: <apgo@patchbomb.org>
Received: from mail15.bluewin.ch (mail15.bluewin.ch [195.186.18.63])
	by ozlabs.org (Postfix) with ESMTP id 726BB6893D
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jan 2006 22:32:48 +1100 (EST)
Date: Wed, 18 Jan 2006 06:09:05 -0500
To: Olaf Hering <olh@suse.de>
Subject: Re: [PATCH] drop linuxppc64-dev
Message-ID: <20060118110905.GA23678@krypton>
References: <20060116121244.GB7171@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060116121244.GB7171@suse.de>
From: apgo@patchbomb.org (Arthur Othieno)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 16, 2006 at 01:12:44PM +0100, Olaf Hering wrote:
> 
> Everything is merged into arch/powerpc now.
> Stop cross-posting.
> 
> Signed-off-by: Olaf Hering <olh@suse.de>
> 
>  Documentation/powerpc/hvcs.txt |    2 +-
>  MAINTAINERS                    |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

[snip]

> Index: linux-2.6.15-olh/MAINTAINERS
> ===================================================================
> --- linux-2.6.15-olh.orig/MAINTAINERS
> +++ linux-2.6.15-olh/MAINTAINERS
> @@ -527,7 +527,7 @@ S:   Supported
>  BROADBAND PROCESSOR ARCHITECTURE
>  P:	Arnd Bergmann
>  M:	arnd@arndb.de
> -L:	linuxppc64-dev@ozlabs.org
> +L:	linuxppc-dev@ozlabs.org
>  W:	http://linuxppc64.org
>  S:	Supported
>  
> @@ -1606,7 +1606,7 @@ P:	Anton Blanchard
>  M:	anton@samba.org
>  M:	anton@au.ibm.com
>  W:	http://linuxppc64.org
> -L:	linuxppc64-dev@ozlabs.org
> +L:	linuxppc-dev@ozlabs.org
>  S:	Supported
>  
>  LINUX SECURITY MODULE (LSM) FRAMEWORK

What about the s/linuxppc64\.org/penguinppc\.org/g case? Or is
penguinppc64.org preferable? Or am I just taking it too far? ;)
