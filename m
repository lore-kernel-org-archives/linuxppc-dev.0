Return-Path: <robh+dt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42147G0xm2zF361
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 11:06:01 +1000 (AEST)
Received: from mail-qt0-f179.google.com (mail-qt0-f179.google.com
 [209.85.216.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BEF8820666
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 01:05:59 +0000 (UTC)
Received: by mail-qt0-f179.google.com with SMTP id k38-v6so8010639qtk.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 18:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <1520208889-3908-1-git-send-email-frowand.list@gmail.com>
 <1520208889-3908-2-git-send-email-frowand.list@gmail.com>
 <alpine.LNX.2.21.1808301025480.73@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1808301025480.73@nippy.intranet>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 29 Aug 2018 20:05:47 -0500
Message-ID: <CAL_JsqLJ9QMHCMqGKpCouP1rTEO+cMGA1es94qAH+ukLsR31jg@mail.gmail.com>
Subject: Re: v4.17 regression: PowerMac G3 won't boot, was Re: [PATCH v5 1/3]
 of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
To: fthain@telegraphics.com.au
Cc: Frank Rowand <frank.rowand@sony.com>, userm57@yahoo.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Chintan Pandya <cpandya@codeaurora.org>, devicetree@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 29, 2018 at 7:44 PM Finn Thain <fthain@telegraphics.com.au> wrote:
>
> Hi Frank,
>
> Linux v4.17 and later will no longer boot on a G3 PowerMac. The boot hangs
> very early, before any video driver loads.
>
> Stan and I were able to bisect the regression between v4.16 and v4.17 and
> arrived at commit 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of
> of_find_node_by_phandle()").
>
> I don't see any obvious bug in 0b3ce78e90fc or b9952b5218ad. But if you
> revert these from v4.18 (which is also affected) that certainly resolves
> the issue.

Perhaps a bad assumption on phandle values causing a problem. Can you
provide a dump of all the phandle or linux,phandle values from
/proc/device-tree.

Rob
