Return-Path: <michel@tungstengraphics.com>
Received: from admin.zirkelwireless.com (admin.zirkelwireless.com
	[209.216.203.65])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BD2BF679E0
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Jul 2006 18:38:57 +1000 (EST)
Subject: Re: DRM git vs. Linux 2.6.17
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
To: Dave Airlie <airlied@linux.ie>
In-Reply-To: <Pine.LNX.4.64.0607251030220.30301@skynet.skynet.ie>
References: <1153818665.20778.82.camel@thor.lorrainebruecke.local>
	<Pine.LNX.4.64.0607251030220.30301@skynet.skynet.ie>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Jul 2006 09:43:07 +0200
Message-Id: <1153899787.20778.99.camel@thor.lorrainebruecke.local>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, dri-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-07-25 at 10:31 +0100, Dave Airlie wrote:
> Did you build you kernel with CONFIG_DRM=y? if so don't.
> 
> to use DRM CVS you need to make sure in-kernel DRM isn't built-in.

Thanks, but I'm quite aware of that. :)

I suspect this might be a PPC specific kernel build system issue related
to Modules.symvers, so I'm CC'ing linuxppc-dev and including the
original post below for reference. Any hints appreciated.


> On Tue, 25 Jul 2006, Michel Dnzer wrote:
> 
> Building DRM git against 2.6.17, I get:
> 
>    Building modules, stage 2.
>    MODPOST
> *** Warning: "drm_addbufs_agp" [/home/michdaen/src/mesa-git/drm/linux-core/drm] duplicated symbol!
> 
> and the same for a lot of DRM core symbols (possibly all of them). The
> resulting DRM core module loads, but the driver doesn't:
> 
> Jul 24 13:47:27 thor kernel: radeon: disagrees about version of symbol drm_open
> Jul 24 13:47:27 thor kernel: radeon: Unknown symbol drm_open
> 
> Removing Module.symvers from the DRM and kernel trees before building
> the DRM avoids these problems. Any ideas where the root of this lies?


-- 
Earthling Michel Dänzer           |          http://tungstengraphics.com
Libre software enthusiast         |          Debian, X and DRI developer
