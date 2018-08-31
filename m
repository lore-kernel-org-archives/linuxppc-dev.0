Return-Path: <userm57@yahoo.com>
Received: from sonic305-21.consmr.mail.ne1.yahoo.com
 (sonic305-21.consmr.mail.ne1.yahoo.com [66.163.185.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 421zDr0pPGzF38X
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2018 22:28:59 +1000 (AEST)
Subject: Re: v4.17 regression: PowerMac G3 won't boot, was Re: [PATCH v5 1/3]
 of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Rob Herring <robh+dt@kernel.org>, fthain@telegraphics.com.au,
 Frank Rowand <frank.rowand@sony.com>, Chintan Pandya
 <cpandya@codeaurora.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <1520208889-3908-1-git-send-email-frowand.list@gmail.com>
 <1520208889-3908-2-git-send-email-frowand.list@gmail.com>
 <alpine.LNX.2.21.1808301025480.73@nippy.intranet>
 <CAL_JsqLJ9QMHCMqGKpCouP1rTEO+cMGA1es94qAH+ukLsR31jg@mail.gmail.com>
 <569e4bc3-2149-4b2d-562f-e400dd05a8a8@yahoo.com>
 <84f13bded54eda0817f9134f355d518d5b3a5f77.camel@kernel.crashing.org>
 <a825ebf4c01f862075006370f418e0b7ab4626ad.camel@kernel.crashing.org>
From: Mac User <userm57@yahoo.com>
Message-ID: <d3f5a177-10ee-1696-1ddf-41b7db62de6c@yahoo.com>
Date: Fri, 31 Aug 2018 06:28:50 -0600
MIME-Version: 1.0
In-Reply-To: <a825ebf4c01f862075006370f418e0b7ab4626ad.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 8/30/18 10:49 PM, Benjamin Herrenschmidt wrote:

> On Fri, 2018-08-31 at 14:35 +1000, Benjamin Herrenschmidt wrote:
>
> ...
> Assuming you are using BootX (or miBoot), can you try this patch ?

Yes, I'm using BootX.

Thanks to Finn for applying the patch (I wouldn't have been sure
which source tree to apply it to).

Thepatched kernel (Finn's vmlinux-4.18.0-00001-gd44cf7e41c19)
boots normally on my Beige G3 Desktop using BootX.

Thanks for working on this!

-Stan
