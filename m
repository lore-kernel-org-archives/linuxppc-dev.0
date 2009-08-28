Return-Path: <david-b@pacbell.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9FDEAB7CCD
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 15:59:21 +1000 (EST)
Received: from n20.bullet.mail.mud.yahoo.com (n20.bullet.mail.mud.yahoo.com
	[68.142.206.147]) by ozlabs.org (Postfix) with SMTP id DEE60DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 15:59:20 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v2 0/8] spi_mpc8xxx: Add support for DMA transfers
Date: Thu, 27 Aug 2009 21:41:59 -0700
References: <20090818220304.GA23640@oksana.dev.rtsoft.ru>
In-Reply-To: <20090818220304.GA23640@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200908272141.59796.david-b@pacbell.net>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 18 August 2009, Anton Vorontsov wrote:

> - Fix build issues in fsl_qe_udc;
> - Some minor cosmetic changes in "Add support for QE DMA mode and
>   CPM1/CPM2 chips" patch.

Hmm ... the first four of these are pure PPC stuff and thus
not appropriate to send as SPI patches; but the second four
depend on them.

So I'll just say

  Acked-by: David Brownell <dbrownell@users.sourceforge.net>

and ask you to merge via the PPC tree.  (And hope that you
verified these are bisectable...)
