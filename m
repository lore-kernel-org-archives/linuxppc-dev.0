Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4396667B9A
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jul 2005 03:03:56 +1000 (EST)
Date: Wed, 13 Jul 2005 19:03:51 +0200
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20050713170351.GA19133@suse.de>
References: <20050713135525.GA18144@suse.de> <20050713135626.GB18144@suse.de>
	<20050713160405.GK7741@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20050713160405.GK7741@smtp.west.cox.net>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] update ppc defconfigs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Wed, Jul 13, Tom Rini wrote:

> > -CONFIG_LOCALVERSION=""
> > +CONFIG_LOCALVERSION="common_defconfig"
> 
> Please don't do that.  $WHOMEVERs mass-compile-scripts should be setting
> this to $WHATEVER.

Will send updated patch.

> > -CONFIG_MODULE_FORCE_UNLOAD=y
> > +# CONFIG_MODULE_FORCE_UNLOAD is not set
> 
> Why?  It looks like you're doing more than running oldconfig here..

That doesnt belong to a default kernel, anyone who wants that can just
enable it.
