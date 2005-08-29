Return-Path: <cfriesen@nortel.com>
Message-ID: <431356C6.3070301@nortel.com>
Date: Mon, 29 Aug 2005 12:41:10 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: Jon Loeliger <jdl@freescale.com>
References: <1123023575.2614.25.camel@cashmere.sps.mot.com>	<688ba2276de281a9473b030a16a514c0@embeddededge.com>	<20050805174705.731ffa05.sfr@canb.auug.org.au>	<200508051353.23750.arnd@arndb.de>	<20050806005941.5d1fe432.sfr@canb.auug.org.au>
	<1125089709.32488.35.camel@cashmere.sps.mot.com>
In-Reply-To: <1125089709.32488.35.camel@cashmere.sps.mot.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] 1/2 Start header file merger (Was: Re: Beginning	Merger
 Patch)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger wrote:

> Anyone care to take a semi-authoritative stand on what
> symbol to use to distinguish 32/64-bit-ness in the
> include files?

I vote for __powerpc64__, if only to make it easier for the people who
have to sanitize the kernel headers for use in userspace.

Chris
