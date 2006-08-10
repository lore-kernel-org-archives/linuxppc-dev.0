Return-Path: <miltonm@bga.com>
Date: Thu, 10 Aug 2006 11:51:30 -0500
From: Milton Miller <miltonm@bga.com>
To: mgreer@mvista.com, hollisb@us.ibm.com,
Subject: Re: [RFC] consolidated libdt proposal
Message-Id: <11155228690643c98691.1714636915.miltonm@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, pantelis@embeddedalley.com,
	linuxppc-embedded@ozlabs.org, xen-ppc-devel@lists.xensource.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue Aug  8 2006 01:04:08 PM CDT, Mark A. Greer wrote:
> If we're going to allow cmdline editing in the bootwrapper, we would
> need to extend the size of a property.  We've never really talked about
> cmdline editing in the powerpc branch but I assume that its a good
> thing(tm).  I know I would like to have it so, IMHO, I think we should
> add it (and therefore require extending a property).

We already have replace the command line merged (it's why my patches
don't apply).

milton
