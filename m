Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Improve -Odts output 
In-Reply-To: Your message of "Wed, 17 Oct 2007 12:39:10 +1000."
	<20071017023910.GH28260@localhost.localdomain>
References: <20071017023910.GH28260@localhost.localdomain> 
Date: Wed, 17 Oct 2007 07:15:45 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Ii7oP-0002XR-1n@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> This patch makes improvements to the way properties are printed when
> in dtc is producing dts output.  
> 	- Characters which need escaping are now properly handled when
> printing properties as strings
> 	- The heuristics for what format to use for a property are
> improved so that 'compatible' properties will be displayed as
> expected.
> 	- escapes.dts is altered to better demonstrate the changes,
> and the string_escapes testcase is adjusted accordingly.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

Thanks,
jdl
