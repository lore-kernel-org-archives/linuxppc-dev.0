Return-Path: <gregkh@linuxfoundation.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
 [209.85.213.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6E88DB77DE
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 02:19:52 +1100 (EST)
Received: by yhnn12 with SMTP id n12so4546151yhn.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2012 08:19:49 -0700 (PDT)
Date: Fri, 16 Mar 2012 08:19:46 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/5] tty/hvc_vio: FW_FEATURE_ISERIES is no longer
 selectable
Message-ID: <20120316151946.GE28696@kroah.com>
References: <20120316151459.dab3cdcc2d5984b05e2d2b5c@canb.auug.org.au>
 <20120316151654.7b2fedd2ecd2132a807630c6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120316151654.7b2fedd2ecd2132a807630c6@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 16, 2012 at 03:16:54PM +1100, Stephen Rothwell wrote:
> so remove the code that tests for it.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/tty/hvc/hvc_vio.c |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
> 
> Greg, it is probably easiest for this to go through the powerpc tree.

Please do:
	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
