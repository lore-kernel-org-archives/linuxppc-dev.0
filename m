Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Implement path references 
In-Reply-To: Your message of "Wed, 05 Dec 2007 10:43:50 +1100."
	<20071204234350.GE9487@localhost.localdomain>
References: <20071204234350.GE9487@localhost.localdomain> 
Date: Wed, 05 Dec 2007 08:47:42 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IzvXK-0005cJ-O8@jdl.com>
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
> This patch extends dtc syntax to allow references (&label, or
> &{/full/path}) directly within property definitions, rather than
> inside a cell list.  Such references are expanded to the full path of
> the referenced node, as a string, instead of to a phandle as
> references within cell lists are evaluated.
> 
> A testcase is also included.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Excellent.  Very timely! :-)

Applied.

jdl
