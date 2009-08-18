Return-Path: <gregkh@suse.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AD241B7BA0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 08:32:41 +1000 (EST)
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 34FD3DDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 08:32:40 +1000 (EST)
Date: Tue, 18 Aug 2009 15:27:47 -0700
From: Greg KH <gregkh@suse.de>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 4/8] powerpc/qe&cpm: Implement static inline stubs for
	non-QE/CPM builds
Message-ID: <20090818222747.GB4354@suse.de>
References: <20090818220304.GA23640@oksana.dev.rtsoft.ru>
	<20090818220418.GD25090@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090818220418.GD25090@oksana.dev.rtsoft.ru>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 19, 2009 at 02:04:18AM +0400, Anton Vorontsov wrote:
> This is needed to avoid ugly #ifdefs in drivers. Also update fsl_qe_udc
> driver so that now it doesn't define its own versions that cause build
> breakage when the generic stubs are used.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

As you're just deleting code, I'll ack that :)

	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

Hopefully you have tested building this thing...

thanks,

greg k-h
