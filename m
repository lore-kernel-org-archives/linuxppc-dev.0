Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EB1B4B7BAE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 09:47:51 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 71EEBDDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 09:47:51 +1000 (EST)
Date: Wed, 19 Aug 2009 03:47:49 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 4/8] powerpc/qe&cpm: Implement static inline stubs for
	non-QE/CPM builds
Message-ID: <20090818234749.GA30824@oksana.dev.rtsoft.ru>
References: <20090818220304.GA23640@oksana.dev.rtsoft.ru>
	<20090818220418.GD25090@oksana.dev.rtsoft.ru>
	<20090818222747.GB4354@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090818222747.GB4354@suse.de>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 18, 2009 at 03:27:47PM -0700, Greg KH wrote:
> On Wed, Aug 19, 2009 at 02:04:18AM +0400, Anton Vorontsov wrote:
> > This is needed to avoid ugly #ifdefs in drivers. Also update fsl_qe_udc
> > driver so that now it doesn't define its own versions that cause build
> > breakage when the generic stubs are used.
> > 
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> 
> As you're just deleting code, I'll ack that :)
> 
> 	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> Hopefully you have tested building this thing...

Yep, thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
