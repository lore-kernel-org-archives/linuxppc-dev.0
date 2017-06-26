Return-Path: <festevam@gmail.com>
Received: from mail-oi0-x22b.google.com (mail-oi0-x22b.google.com
 [IPv6:2607:f8b0:4003:c06::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxCS34CKxzDr1t
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 01:20:50 +1000 (AEST)
Received: by mail-oi0-x22b.google.com with SMTP id p66so2623912oia.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 08:20:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1498489947-17272-1-git-send-email-madalin.bucur@nxp.com>
References: <1498489947-17272-1-git-send-email-madalin.bucur@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 26 Jun 2017 12:20:47 -0300
Message-ID: <CAOMZO5AWgPv6bOFjpt4vC1PSMNpC+dpR2A90+fc2Z_uojoUAmA@mail.gmail.com>
Subject: Re: [PATCH] fsl/fman: add dependency on HAS_DMA
To: madalin.bucur@nxp.com
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 26, 2017 at 12:12 PM, Madalin Bucur <madalin.bucur@nxp.com> wrote:
> A previous commit inserted a dependency on DMA API that requires
> HAS_DMA to be added in Kconfig.

It would be nice to specify the commit that caused this.
