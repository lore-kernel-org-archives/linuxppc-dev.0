Return-Path: <jdl@jdl.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] dtc: Add install makefile target 
In-Reply-To: Your message of "Fri, 29 Jun 2007 09:53:23 CDT."
	<1183128803.30145.29.camel@weaponx.rchland.ibm.com>
References: <1183128803.30145.29.camel@weaponx.rchland.ibm.com> 
Date: Mon, 02 Jul 2007 08:42:22 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1I5MAY-0005jS-Hk@jdl.com>
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Josh Boyer mumbled:
> Add a minimal install target
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Applied with the following changes --amend'ed in as well:

    > +install: dtc ftdump
    > +     $(INSTALL) -d $(DESTDIR)/$(BINDIR)
    > +     $(INSTALL) -m 755 dtc $(DESTDIR)/$(BINDIR)
    > +     $(INSTALL) -m 755 ftdump $(DESTDIR)/$(BINDIR)

    Don't put a slash after $(DESTDIR).  You'll end up with a doulbe slash.

    Andreas.

Thanks,
jdl
