Return-Path: <david-b@pacbell.net>
Received: from smtp121.sbc.mail.sp1.yahoo.com (smtp121.sbc.mail.sp1.yahoo.com
	[69.147.64.94]) by ozlabs.org (Postfix) with SMTP id 4DC72DDFB5
	for <linuxppc-dev@ozlabs.org>; Sun, 25 May 2008 02:50:45 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [spi-devel-general] [PATCH 3/4] spi: Add OF binding support for
	SPI busses
Date: Sat, 24 May 2008 00:13:27 -0700
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<200805221926.24112.david-b@pacbell.net>
	<fa686aa40805232325w65d4f706i50798121a8cce263@mail.gmail.com>
In-Reply-To: <fa686aa40805232325w65d4f706i50798121a8cce263@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200805240013.28044.david-b@pacbell.net>
Cc: fabrizio.garetto@gmail.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 23 May 2008, Grant Likely wrote:
> Very good point.  Okay, so we cannot assume any correlation between
> the number of CS lines and the number of child nodes to the SPI bus.

That wasn't what I was implying ... all the devices hooked
up to a given chipselect should be viewed as a single (albeit
composite) child node.

Now, the driver for that child node may want to expose lots
of substructure.  But that's no different from any other
complex device, whose protocol happens to embed some notion
of component addressing.

It's just that in the case I mentioned, that addressing is
a bit more externally visible than it is in some other cases.

- Dave
