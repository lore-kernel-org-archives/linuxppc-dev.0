Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 87EF6DDFAA
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 10:48:12 +1000 (EST)
Date: Sun, 27 Jul 2008 20:48:05 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: <benh@kernel.crashing.org>
Subject: Re: mISDN still breaking the allmodconfig build...
Message-ID: <20080727204805.59f55dda@lappy.seanm.ca>
In-Reply-To: <1217204022.11188.139.camel@pasglop>
References: <20080727.170235.97056809.davem@davemloft.net>
	<1217204022.11188.139.camel@pasglop>
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

On Mon, 28 Jul 2008 10:13:42 +1000
"Benjamin Herrenschmidt" <benh@kernel.crashing.org> wrote:

> On Sun, 2008-07-27 at 17:02 -0700, David Miller wrote:
> > More fallout from the premature mISDN driver merge:
> > 
> > drivers/isdn/hardware/mISDN/hfcmulti.c:5255:2: error: #error "not
> > running on big endian machines now"
> 
> Lovely...

mISDN is notoriously bad on big endian machines. 

Cheers,
   Sean
