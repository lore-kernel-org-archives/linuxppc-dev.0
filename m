Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 6AAF9DDDFA
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 11:29:35 +1100 (EST)
Date: Tue, 3 Mar 2009 19:29:32 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: "leds: Add openfirmware platform device support" breaks sparc
Message-ID: <20090303192932.31705cf7@lappy.seanm.ca>
In-Reply-To: <20090303160906.9b30b376.akpm@linux-foundation.org>
References: <20090303160906.9b30b376.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	Trent Piepho <tpiepho@freescale.com>,
	Richard Purdie <rpurdie@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 3 Mar 2009 16:09:06 -0800
"Andrew Morton" <akpm@linux-foundation.org> wrote:

> afacit that interface is powerpc-only.

Yes it is. You might want a CONFIG_PPC with that.

It has been..... uhhhh carry the two... longer than I want to admit
since I worked on a sparc. Would GPIO based LEDS make sense on a sparc
platform? Is sparc used much in the embedded world?

If yes, the of_register_platform_driver is just a nice wrapper. It
would be trivial to either change it to work on sparc, or add the
wrapper to the sparc includes.

Cheers,
   Sean
