Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [dtc] Fix flat_dt_property structure 
In-Reply-To: Your message of "Mon, 26 Feb 2007 11:02:24 +1100."
	<20070226000224.GB29826@localhost.localdomain>
References: <20070226000224.GB29826@localhost.localdomain> 
Date: Tue, 27 Feb 2007 08:48:05 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1HM3cb-0002SU-3v@jdl.com>
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
> The structure in flat_dt.h defining the layout of a proprety within
> the flat device tree is incorrect.  It has the offset to the
> property's name, then the length when in fact (according to
> booting-without-of.txt and the output of dtc) then length should come
> first, followed by the name offset.
> 
> In fact, this structure is never used so the mistake doesn't break
> anything, but it should still be fixed to avoid misleading people.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.  Thanks.

jdl
