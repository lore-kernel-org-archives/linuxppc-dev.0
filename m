Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17940.37291.211960.566580@cargo.ozlabs.ibm.com>
Date: Thu, 5 Apr 2007 16:05:31 +1000
From: Paul Mackerras <paulus@samba.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
In-Reply-To: <1175716215.2774.52.camel@shinybook.infradead.org>
References: <1175663999.2932.8.camel@shinybook.infradead.org>
	<17939.15726.114059.679277@cargo.ozlabs.ibm.com>
	<1175666635.2932.17.camel@shinybook.infradead.org>
	<20070404.011208.120446173.davem@davemloft.net>
	<20070404083803.GA13134@flint.arm.linux.org.uk>
	<20070404122154.GF31973@thunk.org> <4613CF6A.2090407@zytor.com>
	<20070404174153.GI31973@thunk.org>
	<20070404181531.GA9388@flint.arm.linux.org.uk>
	<1175716215.2774.52.camel@shinybook.infradead.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Theodore Tso <tytso@mit.edu>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse writes:

> And you always will be. The amount of pain involved in implementing
> this, just so that people can call their serial port 'ttyS0', is _far_
> more than it's worth. It could be done, but it's a completely pointless
> waste of time and effort. 

Avoiding breaking userspace is a completely pointless waste of time
and effort?  Linux is ready for the desktop?  Suuuure it is...

Paul.
