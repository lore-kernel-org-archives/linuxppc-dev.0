Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D670BDDF9E
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 19:38:17 +1000 (EST)
Date: Mon, 28 Jul 2008 10:20:09 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: mISDN still breaking the allmodconfig build...
Message-ID: <20080728102009.5fb3df6b@lxorguk.ukuu.org.uk>
In-Reply-To: <20080727204805.59f55dda@lappy.seanm.ca>
References: <20080727.170235.97056809.davem@davemloft.net>
	<1217204022.11188.139.camel@pasglop>
	<20080727204805.59f55dda@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: sfr@canb.auug.org.au, kkeil@suse.de, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 27 Jul 2008 20:48:05 -0400
Sean MacLennan <smaclennan@pikatech.com> wrote:

> On Mon, 28 Jul 2008 10:13:42 +1000
> "Benjamin Herrenschmidt" <benh@kernel.crashing.org> wrote:
> 
> > On Sun, 2008-07-27 at 17:02 -0700, David Miller wrote:
> > > More fallout from the premature mISDN driver merge:
> > > 
> > > drivers/isdn/hardware/mISDN/hfcmulti.c:5255:2: error: #error "not
> > > running on big endian machines now"
> > 
> > Lovely...
> 
> mISDN is notoriously bad on big endian machines.

In which case it really should not be in Linus tree but in linux-next.
Karsten - will you ask Linus to revert mISDN so it can go into linux-next
instead and get cleaned up in the right place ?

Alan
