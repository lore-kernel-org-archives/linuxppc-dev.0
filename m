Subject: Re: Looking for fast flash programming code
From: David Woodhouse <dwmw2@infradead.org>
To: Eugene Surovegin <ebs@ebshome.net>
Cc: Richard Williams <richard_williams@stratexnet.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20040803003538.GA11101@gate.ebshome.net>
References: 
	 <A3240F62EF3C2749B1A25D3BC9548F4148BC20@ExchWENZ02.wenz.global.vpn>
	 <20040803003538.GA11101@gate.ebshome.net>
Content-Type: text/plain
Message-Id: <1091520922.12594.135.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Date: Tue, 03 Aug 2004 09:15:22 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 2004-08-02 at 17:35 -0700, Eugene Surovegin wrote:
> On Tue, Aug 03, 2004 at 09:13:40AM +1200, Richard Williams wrote:
> >
> > I am looking for fast flash programming code for AMD. Does this exist anywhere?
> >
> > In kernel 2.4.24, amd_flash.c only implements the slow programming algorithm.
>
> IIRC, buffer write support for AMD chips is in MTD CVS.

...which means it's in 2.6 already. Why are you still using 2.4?

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
