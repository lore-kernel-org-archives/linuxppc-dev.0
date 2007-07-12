Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 4DCFCDDDF9
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 19:37:07 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] do firmware feature fixups after features are initialised
Date: Thu, 12 Jul 2007 11:36:48 +0200
References: <9094.1181275235@neuling.org> <200707111329.51580.arnd@arndb.de>
	<27356.1184196225@neuling.org>
In-Reply-To: <27356.1184196225@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200707121136.49170.arnd@arndb.de>
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 12 July 2007, Michael Neuling wrote:
> 
> > If I'm understanding this right, the first solution should be something
> > along the lines of the patch below (not tested), which even removes
> > more lines than it adds. It doesn't seem that annoying to me, and it
> > makes sense to assume that the fw_features are set up after returning
> > from the ppc_md probe.
> 
> I'm not sure this patch is going to work as the do_feature_fixups isn't
> called any earlier?

Right, my patch still assumes that yours gets removed.

	Arnd <><
