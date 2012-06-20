Return-Path: <ralf@linux-mips.org>
Received: from h5.dl5rb.org.uk
 (6.d.2.3.5.8.4.2.8.7.3.5.9.9.5.0.0.0.0.0.a.e.3.0.0.b.8.0.1.0.0.2.ip6.arpa
 [IPv6:2001:8b0:3ea:0:599:5378:2485:32d6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B5D0EB6FAC
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Jun 2012 02:36:17 +1000 (EST)
Date: Wed, 20 Jun 2012 17:12:49 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Yoichi Yuasa <yuasa@linux-mips.org>
Subject: Re: [PATCH] MIPS: fix bug.h MIPS build regression
Message-ID: <20120620161249.GB29196@linux-mips.org>
References: <1339962373-3224-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdVfLjgrtWoPpvbLf12+=ApE6W9dNcweqD-_2Benr-D7NQ@mail.gmail.com>
 <20120620152759.2caceb8c.yuasa@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120620152759.2caceb8c.yuasa@linux-mips.org>
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 Linux-sh list <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org,
 Linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mundt <lethal@linux-sh.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Chris Zankel <chris@zankel.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 20, 2012 at 03:27:59PM +0900, Yoichi Yuasa wrote:

> Commit: 3777808873b0c49c5cf27e44c948dfb02675d578 breaks all MIPS builds.

Thanks, fix applied.

  Ralf
