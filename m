Return-Path: <dgibson@ozlabs.org>
Date: Fri, 4 Jan 2008 10:25:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [DTC] small ftdump cleanup patch
Message-ID: <20080103232520.GA12883@localhost.localdomain>
References: <20080103144056.GB28644@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080103144056.GB28644@windriver.com>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 03, 2008 at 09:40:57AM -0500, Paul Gortmaker wrote:
> Here is a small patch to clean up the usage info and the error returns
> for ftdump -- not sure what the future holds for ftdump vs. simply using
> "dtc -I dtb -O dts someblob.dtb" ...

I expect ftdump to stay around for the forseeable future as a
hacking/debugging tool; the idea is that it will be able to tell you
at least something about a malformed or corrupted dtb, whereas dtc is
likely to choke before producing any output.  Any non-debugging use is
likely a mistake, though.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
