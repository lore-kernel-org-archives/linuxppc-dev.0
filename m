Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7P3x75VczDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 00:08:29 +1000 (AEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 979AAAB46
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 14:08:26 +0000 (UTC)
Date: Wed, 19 Apr 2017 16:08:26 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/2] fadump: reduce memory consumption for capture
 kernel
Message-ID: <20170419160826.617d173f@kitsune.suse.cz>
In-Reply-To: <878tmx6nbw.fsf@concordia.ellerman.id.au>
References: <148647105867.9464.16492047069430229118.stgit@hbathini.in.ibm.com>
 <878tnd7zim.fsf@concordia.ellerman.id.au>
 <d50dfb98-68ac-0135-8e65-560aec1d752e@linux.vnet.ibm.com>
 <87efx4gwk2.fsf@concordia.ellerman.id.au>
 <e1377bf8-e574-6ffa-6b63-3748a01dcdfa@linux.vnet.ibm.com>
 <20170413215826.367dbdf0@kitsune.suse.cz>
 <c1591a61-6499-4364-9d37-a3035e0eaddf@linux.vnet.ibm.com>
 <20170418161816.20e124f0@kitsune.suse.cz>
 <878tmx6nbw.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 19 Apr 2017 14:19:47 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Michal Such=C3=A1nek <msuchanek@suse.de> writes:
> > On Mon, 17 Apr 2017 20:43:02 +0530
> > Hari Bathini <hbathini@linux.vnet.ibm.com> wrote: =20
> >> On Friday 14 April 2017 01:28 AM, Michal Such=C3=A1nek wrote: =20
> >> > more (optional) properties cannot be added?   =20
> >>=20
> >> Kernel change seems simple over f/w enhancement.. =20
> >
> > That certainly looks so when you are a kernel developer and can
> > implement the change yourself compared to convincing some firmware
> > developer that this feature makes sense.
> >
> > On the other hand, the proposed kernel-only solution introduces
> > requirement that the maintainer does not like.
> >
> > For the platform as a whole does it make more sense to add a hack to
> > the kernel or does it make sense to enhance the firmware to provide
> > more options for firmware-assisted dump? =20
>=20
> Unfortunately it doesn't really matter, because there is firmware out
> there that implements the current behaviour and will never be updated.
> So we have to work with what's there.
>=20

It's not that with the existing firmware fadump does not work. It just
uses more memory than needed. So if new firmware revision allows more
flexibility it will work for people with updated firmware and people
with outdated firmware will get the current behavior.

The memory saving is only significant for big systems so only people
running those will get significant improvement from the updated
firmware.

Thanks

Michal
