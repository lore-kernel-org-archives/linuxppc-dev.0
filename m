Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A164CB70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  5 Sep 2009 02:37:31 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 326F0DDD01
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Sep 2009 02:37:30 +1000 (EST)
Date: Fri, 4 Sep 2009 20:37:27 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 0/8] spi_mpc8xxx: Add support for DMA transfers
Message-ID: <20090904163727.GA27358@oksana.dev.rtsoft.ru>
References: <20090818220304.GA23640@oksana.dev.rtsoft.ru>
	<200908272141.59796.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200908272141.59796.david-b@pacbell.net>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
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

On Thu, Aug 27, 2009 at 09:41:59PM -0700, David Brownell wrote:
> On Tuesday 18 August 2009, Anton Vorontsov wrote:
> 
> > - Fix build issues in fsl_qe_udc;
> > - Some minor cosmetic changes in "Add support for QE DMA mode and
> >   CPM1/CPM2 chips" patch.
> 
> Hmm ... the first four of these are pure PPC stuff and thus
> not appropriate to send as SPI patches; but the second four
> depend on them.
> 
> So I'll just say
> 
>   Acked-by: David Brownell <dbrownell@users.sourceforge.net>
> 
> and ask you to merge via the PPC tree.  (And hope that you
> verified these are bisectable...)

Thanks David.

Kumar, can you please merge the SPI part of this patch set?

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
