Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 422P5K25M7zF39J
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Sep 2018 14:53:57 +1000 (AEST)
Message-ID: <46510acd915b463f1944adb0a7e60c10460f9d7e.camel@kernel.crashing.org>
Subject: Re: v4.17 regression: PowerMac G3 won't boot, was Re: [PATCH v5
 1/3] of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mac User <userm57@yahoo.com>
Cc: Rob Herring <robh+dt@kernel.org>, fthain@telegraphics.com.au, Frank
 Rowand <frank.rowand@sony.com>, Chintan Pandya <cpandya@codeaurora.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Sat, 01 Sep 2018 14:53:43 +1000
In-Reply-To: <d3f5a177-10ee-1696-1ddf-41b7db62de6c@yahoo.com>
References: <1520208889-3908-1-git-send-email-frowand.list@gmail.com>
 <1520208889-3908-2-git-send-email-frowand.list@gmail.com>
 <alpine.LNX.2.21.1808301025480.73@nippy.intranet>
 <CAL_JsqLJ9QMHCMqGKpCouP1rTEO+cMGA1es94qAH+ukLsR31jg@mail.gmail.com>
 <569e4bc3-2149-4b2d-562f-e400dd05a8a8@yahoo.com>
 <84f13bded54eda0817f9134f355d518d5b3a5f77.camel@kernel.crashing.org>
 <a825ebf4c01f862075006370f418e0b7ab4626ad.camel@kernel.crashing.org>
 <d3f5a177-10ee-1696-1ddf-41b7db62de6c@yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-08-31 at 06:28 -0600, Mac User wrote:
> On 8/30/18 10:49 PM, Benjamin Herrenschmidt wrote:
> 
> > On Fri, 2018-08-31 at 14:35 +1000, Benjamin Herrenschmidt wrote:
> > 
> > ...
> > Assuming you are using BootX (or miBoot), can you try this patch ?
> 
> Yes, I'm using BootX.
> 
> Thanks to Finn for applying the patch (I wouldn't have been sure
> which source tree to apply it to).
> 
> Thepatched kernel (Finn's vmlinux-4.18.0-00001-gd44cf7e41c19)
> boots normally on my Beige G3 Desktop using BootX.
> 
> Thanks for working on this!

Well it's still a sign of something wrong with the new code, my patch
just band-aids by creating fake phandles. I would be interesting to
figure out what causes the new code to barf.

Cheers,
Ben.
