Return-Path: <dgibson@ozlabs.org>
Date: Fri, 6 Jun 2008 08:52:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 1/4] [POWERPC] 85xx: add board support for the
	TQM8548 modules
Message-ID: <20080605225215.GF30980@yookeroo.seuss>
References: <4847AC75.8080405@grandegger.com>
	<71165662-0864-4CDE-A1B3-29487253B85F@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <71165662-0864-4CDE-A1B3-29487253B85F@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 05, 2008 at 08:43:51AM -0500, Kumar Gala wrote:
>
> On Jun 5, 2008, at 4:05 AM, Wolfgang Grandegger wrote:
[snip]
>> +			timebase-frequency = <0>;	// from U-Boot
>> +			bus-frequency = <0>;	// from U-Boot
>> +			clock-frequency = <0>;	// from U-Boot
>
> u-boot will add this for us so no need for them.

I think it's worth including them (with the comments) for
documentation purposes though.  Plus allowing the bootloader and
bootwrapper to just replace property values without resizing or
inserting is somewhat worthwhile of itself.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
