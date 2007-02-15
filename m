Return-Path: <dgibson@ozlabs.org>
Date: Fri, 16 Feb 2007 09:57:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Dan Malek <dan@embeddedalley.com>
Subject: Re: [DTC PATCH] Add support for decimal,
	octal and binary based cell values.
Message-ID: <20070215225739.GA21654@localhost.localdomain>
References: <E1HHkAL-0005Xl-2f@jdl.com>
	<70840B5D-F927-4CC6-84D3-789DA8A66378@embeddedalley.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <70840B5D-F927-4CC6-84D3-789DA8A66378@embeddedalley.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 15, 2007 at 02:33:47PM -0800, Dan Malek wrote:
> 
> On Feb 15, 2007, at 9:13 AM, Jon Loeliger wrote:
> 
> > New syntax d#, b#, o# and h# allow for an explicit prefix
> > on cell values to specify their base.  Eg: <d# 123>
> 
> Why do we need yet another syntax?  Everyone
> else, including most silicon documentation, uses
> the standard "C" syntax 0x for hex, 0 for octal, and
> nothing for decimal.  If really needed binary, we
> could us the '0b'.  Of the few dts files I've done,
> anything to make this easier, rather than inventing
> something new, would be appreciated.

Yes, but hex-by-default is already implemented and out there.  We
can't change it without breaking compatibility horribly.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
