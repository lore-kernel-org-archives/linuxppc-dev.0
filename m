Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] do firmware feature fixups after features are initialised
In-reply-to: <200707121136.49170.arnd@arndb.de> 
References: <9094.1181275235@neuling.org> <200707111329.51580.arnd@arndb.de>
	<27356.1184196225@neuling.org> <200707121136.49170.arnd@arndb.de>
Date: Thu, 12 Jul 2007 10:15:00 -0500
Message-ID: <21593.1184253300@neuling.org>
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > > If I'm understanding this right, the first solution should be something
> > > along the lines of the patch below (not tested), which even removes
> > > more lines than it adds. It doesn't seem that annoying to me, and it
> > > makes sense to assume that the fw_features are set up after returning
> > > from the ppc_md probe.
> > 
> > I'm not sure this patch is going to work as the do_feature_fixups isn't
> > called any earlier?
> 
> Right, my patch still assumes that yours gets removed.

Arrh, cool.. that would better :-)

Mikey
