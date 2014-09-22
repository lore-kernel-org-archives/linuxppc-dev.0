Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 135131A0399
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2014 08:59:04 +1000 (EST)
Message-ID: <1411426743.25517.0.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH 03/15] powerpc/msi: Improve IRQ bitmap allocator
From: Michael Neuling <mikey@neuling.org>
To: Laurentiu Tudor <b10716@freescale.com>
Date: Tue, 23 Sep 2014 08:59:03 +1000
In-Reply-To: <541FDDD6.9040009@freescale.com>
References: <1411028820-29933-1-git-send-email-mikey@neuling.org>
 <1411028820-29933-4-git-send-email-mikey@neuling.org>
 <541FDDD6.9040009@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, arnd@arndb.de, greg@kroah.com,
 imunsie@au.ibm.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 anton@samba.org, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > diff --git a/arch/powerpc/sysdev/msi_bitmap.c b/arch/powerpc/sysdev/msi=
_bitmap.c
> > index 2ff6302..e001559 100644
> > --- a/arch/powerpc/sysdev/msi_bitmap.c
> > +++ b/arch/powerpc/sysdev/msi_bitmap.c
> > @@ -24,28 +24,36 @@ int msi_bitmap_alloc_hwirqs(struct msi_bitmap *bmp,=
 int num)
> >  	 * This is fast, but stricter than we need. We might want to add
> >  	 * a fallback routine which does a linear search with no alignment.
> >  	 */
>=20
> Is this comment still relevant (especially the part mentioning "fast")?

You're right, it's not really relevant any more.  I'll remove.

Thanks
Mikey
