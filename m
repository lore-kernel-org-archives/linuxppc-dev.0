Return-Path: <david-b@pacbell.net>
Received: from smtp128.sbc.mail.sp1.yahoo.com (smtp128.sbc.mail.sp1.yahoo.com
	[69.147.65.187]) by ozlabs.org (Postfix) with SMTP id 8813FB7E3B
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jan 2010 08:01:22 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 1/4] gpiolib: Introduce chip addition/removal notifier
Date: Tue, 26 Jan 2010 13:01:05 -0800
References: <20100125180957.GA5380@oksana.dev.rtsoft.ru>
	<201001252234.30169.david-b@pacbell.net>
	<20100126172824.GA20319@oksana.dev.rtsoft.ru>
In-Reply-To: <20100126172824.GA20319@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201001261301.05475.david-b@pacbell.net>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Bill Gatliff <bgat@billgatliff.com>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 26 January 2010, Anton Vorontsov wrote:
> > Just
> > inline the little two blocking_notifier_call_chain() calls directly,
> > making this a *LOT* simpler.
> 
> I'd rather stay with gpio_call_chain() helper, it makes the code
> a little bit prettier, IMO. Compare this:

The one without the wrapper is IMO more clear, since it doesn't
obfuscate anything.  Fewer lines of code, too.  :)

Pretty is a good attribute ... but is a distant third to clarity.
