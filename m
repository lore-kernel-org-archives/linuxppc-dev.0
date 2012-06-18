Return-Path: <R1AAHA@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0B6D7B7084
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2012 06:30:08 +1000 (EST)
Date: Mon, 18 Jun 2012 15:27:58 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Mauro Carvalho Chehab
 <mchehab@redhat.com>
Subject: Re: Build regressions/improvements in v3.5-rc3
Message-ID: <20120618152758.3a0a28c7f68615e9e2599ee3@freescale.com>
In-Reply-To: <CAMuHMdVfLjgrtWoPpvbLf12+=ApE6W9dNcweqD-_2Benr-D7NQ@mail.gmail.com>
References: <1339962373-3224-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdVfLjgrtWoPpvbLf12+=ApE6W9dNcweqD-_2Benr-D7NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>, linux-kernel@vger.kernel.org,
 Chris Zankel <chris@zankel.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 17 Jun 2012 21:56:59 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

>   + drivers/edac/mpc85xx_edac.c: error: too few arguments to function
> 'edac_mc_alloc':  => 983:90
> 
> powerpc-randconfig

fixed in linux-next commit b9bc5dd, should have been upstreamed by
now [1] - Mauro?

Kim

[1] http://marc.info/?l=linux-edac&m=133942731507920&w=2
