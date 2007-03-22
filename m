Return-Path: <dgibson@ozlabs.org>
Date: Thu, 22 Mar 2007 12:36:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/4] powerpc: Add device tree utility functions to zImage
Message-ID: <20070322013616.GH2295@localhost.localdomain>
References: <20070321063031.GB30422@localhost.localdomain>
	<20070321063150.04BA4DDE9F@ozlabs.org>
	<20070321215741.GA5540@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070321215741.GA5540@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 21, 2007 at 04:57:41PM -0500, Scott Wood wrote:
> On Wed, Mar 21, 2007 at 05:31:49PM +1100, David Gibson wrote:
> > +int dt_path_getprop(const char *path, const char *name, void *buf, int bufsize)
> > +{
> > +	void *devp = finddevice;
> > +
> > +	if (devp)
> > +		return getprop(devp, name, buf, bufsize);
> > +	return -1;
> > +}
> 
> Should be "void *devp = finddevice(path);".

Eep.  Yes.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
