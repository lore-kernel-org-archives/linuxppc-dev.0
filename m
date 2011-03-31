Return-Path: <glikely@secretlab.ca>
Received: from mail-px0-f170.google.com (mail-px0-f170.google.com
	[209.85.212.170]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 173C8B6F76
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Apr 2011 02:58:40 +1100 (EST)
Received: by pxi19 with SMTP id 19so543908pxi.15
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 31 Mar 2011 08:58:38 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Thu, 31 Mar 2011 09:58:34 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] powerpc: dtc: remove obsolete .gitignore entries
Message-ID: <20110331155834.GE26709@ponder.secretlab.ca>
References: <1299948250-32084-1-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1299948250-32084-1-git-send-email-w.sang@pengutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 12, 2011 at 05:44:10PM +0100, Wolfram Sang wrote:
> dtc was moved and .gitignores have been added to the new location. So, we can
> delete the old, forgotten ones.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

It's Ben's jurisdiction, but I've picked it up into my
devicetree/merge branch anyway.  If I don't hear from Ben either way
then I'll push it out to Linus next week.

g.

> ---
>  arch/powerpc/boot/.gitignore         |    1 -
>  arch/powerpc/boot/dtc-src/.gitignore |    3 ---
>  2 files changed, 0 insertions(+), 4 deletions(-)
>  delete mode 100644 arch/powerpc/boot/dtc-src/.gitignore
> 
> diff --git a/arch/powerpc/boot/.gitignore b/arch/powerpc/boot/.gitignore
> index 3d80c3e..12da77e 100644
> --- a/arch/powerpc/boot/.gitignore
> +++ b/arch/powerpc/boot/.gitignore
> @@ -1,5 +1,4 @@
>  addnote
> -dtc
>  empty.c
>  hack-coff
>  infblock.c
> diff --git a/arch/powerpc/boot/dtc-src/.gitignore b/arch/powerpc/boot/dtc-src/.gitignore
> deleted file mode 100644
> index a7c3f94..0000000
> --- a/arch/powerpc/boot/dtc-src/.gitignore
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -dtc-lexer.lex.c
> -dtc-parser.tab.c
> -dtc-parser.tab.h
> -- 
> 1.7.2.3
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
