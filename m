Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 290341A0007
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 11:26:20 +1100 (AEDT)
Message-ID: <1457483176.5360.121.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Nora =?ISO-8859-1?Q?Bj=F6rklund?= <Nora.Bjorklund@enea.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 08 Mar 2016 18:26:16 -0600
In-Reply-To: <1456846859.1203.6.camel@enea.com>
References: <1456846859.1203.6.camel@enea.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: GPIO expander for p2041
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-03-01 at 15:41 +0000, Nora Björklund wrote:
> Hi,
> 
> I was working on a p2041rdb target not so long ago and needed to use
> the gpio pins (described in detail in the p2041 reference manual),
> these are visible on the p2041 fact sheet [1]. The pins are connected
> to a gpio expander, PCA9672 [2], which is connected to a i2c-bus. 
> 
> The expander was not available in the device-tree for p2041rdb so I
> patched it locally to include it. The gpio-expander does not seem to be
> available in any upstream repository either (at this time I was working
> on a version of the 3.12 kernel, but it seems to be the same for the
> one I obtained from
> git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git).
> 
> Would this patch be of any interest for the upstream powerpc kernel?
> The gpio pins are there on all p2041rdb targets (at least since they
> are mentioned as such in the reference guide), so I could not come up
> with a reason to why it is excluded from the device tree.

In theory the device tree should completely describe the hardware, regardless
of what Linux looks for, but in practice some things get missed and then get
added as they're needed.

Yes, a patch would be welcome.

-Scott
