Return-Path: <michel@tungstengraphics.com>
Received: from admin.zirkelwireless.com (admin.zirkelwireless.com
	[209.216.203.65])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 48C8267B32
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Jul 2006 00:38:59 +1000 (EST)
Subject: Re: DRM git vs. Linux 2.6.17
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
To: Dave Airlie <airlied@linux.ie>
In-Reply-To: <1153899787.20778.99.camel@thor.lorrainebruecke.local>
References: <1153818665.20778.82.camel@thor.lorrainebruecke.local>
	<Pine.LNX.4.64.0607251030220.30301@skynet.skynet.ie>
	<1153899787.20778.99.camel@thor.lorrainebruecke.local>
Content-Type: text/plain; charset=utf-8
Date: Wed, 26 Jul 2006 16:38:46 +0200
Message-Id: <1153924726.20778.116.camel@thor.lorrainebruecke.local>
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

On Wed, 2006-07-26 at 09:43 +0200, Michel Dänzer wrote:
> 
> I suspect this might be a PPC specific kernel build system issue related
> to Modules.symvers, 

Actually, now that my x86_64 box is back up, it happens there as well,
so maybe it's related to the Debian toolchain or kernel packaging.
Apologies to linuxppc-dev for the false alarm.


-- 
Earthling Michel Dänzer           |          http://tungstengraphics.com
Libre software enthusiast         |          Debian, X and DRI developer
