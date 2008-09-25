Return-Path: <david-b@pacbell.net>
Received: from smtp121.sbc.mail.sp1.yahoo.com (smtp121.sbc.mail.sp1.yahoo.com
	[69.147.64.94]) by ozlabs.org (Postfix) with SMTP id B4F46DDDF3
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 14:13:22 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 2/4] powerpc/qe: new call to revert a gpio to a dedicated
	function
Date: Wed, 24 Sep 2008 21:13:18 -0700
References: <20080924000255.GA28054@oksana.dev.rtsoft.ru>
	<200809241154.25722.david-b@pacbell.net>
	<20080924232956.GA27533@oksana.dev.rtsoft.ru>
In-Reply-To: <20080924232956.GA27533@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200809242113.18992.david-b@pacbell.net>
Cc: Greg Kroah-Hartman <greg@kroah.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Li Yang <leoli@freescale.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 24 September 2008, Anton Vorontsov wrote:
> 
> Anyway, just want to thank you for your time and persistence on this
> matter, you're forcing others' people brains to *work*.  And since you 
> rejected this approach too, I have no other option but to implement
> something else... something better. ;-)

I think you have enough pieces in place to get that
"something better" _very_ quickly.  Or I'd feel worse
about abusing those poor little grey cells.  ;)
