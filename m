Return-Path: <dgibson@ozlabs.org>
Date: Sun, 18 Mar 2007 10:13:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jerry Van Baren <gerald.vanbaren@comcast.net>
Subject: Re: [PATCH] DTC: Improve options handling
Message-ID: <20070317231337.GA11017@localhost.localdomain>
References: <45FC1F69.9080204@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45FC1F69.9080204@comcast.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Mar 17, 2007 at 01:03:37PM -0400, Jerry Van Baren wrote:
> Hi David, Jon,
> 
> Here is another fairly trivial patch for dtc.  It adds -h to get the 
> usage message.  It adds -q (-qq/-qqq) to suppress warnings/errors.
> It removes the -R option which is advertised but does nothing
> useful.

NAK.  -R does do something that I believe is useful.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
