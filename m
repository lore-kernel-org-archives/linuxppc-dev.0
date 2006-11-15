Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2CEAF67CE9
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 04:54:33 +1100 (EST)
Date: Wed, 15 Nov 2006 18:54:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 7/16] powerpc: add support for ps3 platform
Message-ID: <20061115175425.GA18856@lst.de>
References: <4554DACB.8060809@am.sony.com> <20061110152310.7419ef3e@pb15>
	<4559099A.6060805@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4559099A.6060805@am.sony.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 13, 2006 at 04:11:06PM -0800, Geoff Levand wrote:
> > platform" which expands to "this is the ps3 platform platform"? ps3 is
> > quite adequate as the platform name. :-)
> 
> I had it as ps3, but I was told to change it to ps3pf.

Who told you to use ps3pf?  I think we should shoot that person
for beein stupid.  It's definitly not an acceptable name.
I think the most sensible one for now is ps3hv, unless the
rumoured cell based workstation from sony can share the port,
in which case sonyhv would make a lot more sense.
