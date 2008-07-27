Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.234])
	by ozlabs.org (Postfix) with ESMTP id 1AF24DDF26
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 14:04:49 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so3259445rvb.9
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 21:04:47 -0700 (PDT)
Date: Sat, 26 Jul 2008 20:20:54 -0400
From: Grant Likely <grant.likely@secretlab.ca>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH v3 5/5] powerpc/mpc5200: Add mpc5200-spi (non-PSC)
	device driver
Message-ID: <20080727002054.GC12191@secretlab.ca>
References: <20080712083437.14782.65551.stgit@trillian.secretlab.ca>
	<20080712083458.14782.59382.stgit@trillian.secretlab.ca>
	<9e4733910807140621g69707c46tc23d26e9cf030c5c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910807140621g69707c46tc23d26e9cf030c5c@mail.gmail.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, dbrownell@users.sourceforge.net,
	spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 14, 2008 at 09:21:08AM -0400, Jon Smirl wrote:
> On 7/12/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> > From: Grant Likely <grant.likely@secretlab.ca>
> >
> >  Adds support for the dedicated SPI device on the Freescale MPC5200(b)
> >  SoC.
> 
> Can you adjust the existing PSC based SPI driver to use this device
> tree code? It will be confusing if there are two different ways to do
> SPI on the mpc5200.

Yes, I'll do that and post the patch

g.
