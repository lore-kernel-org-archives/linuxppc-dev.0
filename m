Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by ozlabs.org (Postfix) with ESMTP id F2D3CDDDFC
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 10:53:51 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id a29so3821516pyi
	for <linuxppc-dev@ozlabs.org>; Mon, 05 Nov 2007 15:53:50 -0800 (PST)
Date: Mon, 5 Nov 2007 17:53:41 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] 4xx; Replace #includes of asm/of_platform.h with
	linux/of_platform.h.
Message-ID: <20071105175341.6ee15106@vader.jdub.homelinux.org>
In-Reply-To: <20071106094014.cd429711.sfr@canb.auug.org.au>
References: <1194299023.7158.59.camel@ld0161-tx32>
	<20071106094014.cd429711.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 6 Nov 2007 09:40:14 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> On Mon, 05 Nov 2007 15:43:43 -0600 Jon Loeliger <jdl@freescale.com> wrote:
> >
> > From: Jon Loeliger <jdl@freescale.com>
> > 
> > Signed-off-by: Jon Loeliger <jdl@freescale.com>
> 
> Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

Yeah, this is fine with me too.  But why haven't we put a #warning in
asm/of_platform.h and asm/prom.h?

josh
