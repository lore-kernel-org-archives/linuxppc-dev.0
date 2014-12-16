Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0013D1A030F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Dec 2014 10:50:46 +1100 (AEDT)
Message-ID: <1418773844.6400.6.camel@ellerman.id.au>
Subject: Re: [PATCH 13/18] powerpc/uaccess: fix sparse errors
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Michael S. Tsirkin" <mst@redhat.com>
Date: Wed, 17 Dec 2014 10:50:44 +1100
In-Reply-To: <20141216164746.GB21876@redhat.com>
References: <1418575877-21488-1-git-send-email-mst@redhat.com>
 <1418575877-21488-14-git-send-email-mst@redhat.com>
 <20141216164746.GB21876@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-12-16 at 18:47 +0200, Michael S. Tsirkin wrote:
> On Sun, Dec 14, 2014 at 06:52:51PM +0200, Michael S. Tsirkin wrote:
> > virtio wants to read bitwise types from userspace using get_user.  At the
> > moment this triggers sparse errors, since the value is passed through an
> > integer.
> > 
> > Fix that up using __force.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Ping.

Ping? You only sent it two days ago. And you only responded to my questions
yesterday evening.

> Do powerpc maintainers consider fixing sparse errors
> applicable for 3.19?

Yeah, with your expanded explanation I'm fine with it.

> If yes, can you pls merge this patch?

Yes I will.

cheers
