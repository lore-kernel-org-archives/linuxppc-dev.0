Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Convert "name" property checking to new infrastructure 
In-Reply-To: Your message of "Wed, 05 Dec 2007 09:40:23 +1100."
	<20071204224023.GA9487@localhost.localdomain>
References: <20071204224023.GA9487@localhost.localdomain> 
Date: Wed, 05 Dec 2007 08:40:19 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IzvQB-0005a2-Nv@jdl.com>
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
> This patch removes the old-style checking code for the "name" property
> - i.e. verifying that the "name" property, if present, matches the
> node name.  It replaces it with a pair of more-or-less equivalent
> checks in the new checking framework.
> 
> This also promotes this check to a "structural" check, or at least an
> error-rather-than-warning test, since the structural/semantic
> distinction doesn't really apply in the new framework.
> 
> A testcase for the check is also added.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
