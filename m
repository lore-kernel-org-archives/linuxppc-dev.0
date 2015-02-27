Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B306A1A0001
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 13:05:38 +1100 (AEDT)
Message-ID: <1425002721.4645.43.camel@kernel.crashing.org>
Subject: Re: [PATCH 03/15] fbdev: aty128fb: replace PPC_OF with PPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Hao <haokexin@gmail.com>
Date: Fri, 27 Feb 2015 13:05:21 +1100
In-Reply-To: <20150227010549.GA10596@pek-khao-d1.corp.ad.wrs.com>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
 <1422712065-9403-4-git-send-email-haokexin@gmail.com>
 <1424995875.4645.42.camel@kernel.crashing.org>
 <20150227010549.GA10596@pek-khao-d1.corp.ad.wrs.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Tomi Valkeinen <tomi.valkeinen@ti.com>, Paul Mackerras <paulus@samba.org>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-02-27 at 09:05 +0800, Kevin Hao wrote:
> On Fri, Feb 27, 2015 at 11:11:15AM +1100, Benjamin Herrenschmidt wrote:
> > On Sat, 2015-01-31 at 21:47 +0800, Kevin Hao wrote:
> > > The PPC_OF is a ppc specific option which is used to mean that the
> > > firmware device tree access functions are available. Since all the
> > > ppc platforms have a device tree, it is aways set to 'y' for ppc.
> > > So it makes no sense to keep a such option in the current kernel.
> > > Replace it with PPC.
> > > 
> > > Signed-off-by: Kevin Hao <haokexin@gmail.com>
> > 
> > For this and generally the whole series,
> > 
> > Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Thanks Ben.
> 
> > 
> > Which tree do we expect this to go through ?
> 
> I just sent out a v2 [1] a few hours earlier with some minor updates. We plan
> to merge this patch series via the powerpc tree in 4.1 cycle if I can collect
> all the acks from the corresponding driver maintainers.
> 
> [1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-February/125331.html

Anything I'm the maintainer by default for has my ack (radeonfb,
aty128fb, ...)

Cheers,
Ben.
