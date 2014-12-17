Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42CB21A0549
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Dec 2014 22:05:23 +1100 (AEDT)
Message-ID: <1418814312.27103.18.camel@kernel.crashing.org>
Subject: Re: [PATCH 13/18] powerpc/uaccess: fix sparse errors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 17 Dec 2014 22:05:12 +1100
In-Reply-To: <3268591.VzqP3kr6UD@wuerfel>
References: <1418575877-21488-1-git-send-email-mst@redhat.com>
 <20141216164746.GB21876@redhat.com>
 <1418777556.27103.7.camel@kernel.crashing.org> <3268591.VzqP3kr6UD@wuerfel>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-12-17 at 11:53 +0100, Arnd Bergmann wrote:
> On Wednesday 17 December 2014 11:52:36 Benjamin Herrenschmidt wrote:
> > On Tue, 2014-12-16 at 18:47 +0200, Michael S. Tsirkin wrote:
> > > On Sun, Dec 14, 2014 at 06:52:51PM +0200, Michael S. Tsirkin wrote:
> > > > virtio wants to read bitwise types from userspace using get_user.  At the
> > > > moment this triggers sparse errors, since the value is passed through an
> > > > integer.
> > > > 
> > > > Fix that up using __force.
> > > > 
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > 
> > > Ping.
> > > Do powerpc maintainers consider fixing sparse errors
> > > applicable for 3.19?
> > > If yes, can you pls merge this patch?
> > 
> > Relax  Our patches are tracked in Patchwork and such fixes aren't
> > necessarily constrained by the merge window. Michael will probably
> > pick it up but don't expect systematic replies to patches in 2 days ...
> > 
> > Also, when sending a series like that where one of us only gets
> > CCed on one of the patch, it helps to make it clear whether you
> > only expect an ack or whether you expect us to take the patch.
> 
> Michael initially asked how these patches should merged, and as I
> discussed with him on IRC, I wouldn't take them through the asm-generic
> tree for 3.19 at this point, but I offered to take the ones that
> are not picked up by arch maintainers through that tree for 3.20.
> 
> I also recommend to him to clarify this with maintainers of the
> architectures he cares about most so they can decide whether to pick
> it up or not, which triggered the message above.

Ok, I incorrectly assumed the above was a nag for not looking at his
patch yet :)

I don't have any objection, but I'm leaving the merging for now to
Michael (and possibly for ever, we'll see ... :) as I'm on vacation
until end of January.

Cheers,
Ben.
