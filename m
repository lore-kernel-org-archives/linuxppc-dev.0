Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (71-36-219-11.roch.qwest.net [71.36.219.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9A72767B24
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jun 2006 05:28:53 +1000 (EST)
Subject: Re: "merge" branch reset in powerpc.git tree
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
In-Reply-To: <200606232124.52879.arnd.bergmann@de.ibm.com>
References: <17563.54330.600099.894958@cargo.ozlabs.ibm.com>
	<17564.6980.694265.974713@hound.rchland.ibm.com>
	<1151089824.22158.2.camel@weaponx.rchland.ibm.com>
	<200606232124.52879.arnd.bergmann@de.ibm.com>
Content-Type: text/plain
Date: Fri, 23 Jun 2006 14:28:33 -0500
Message-Id: <1151090913.22158.5.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-06-23 at 21:24 +0200, Arnd Bergmann wrote:
> On Friday 23 June 2006 21:10, Josh Boyer wrote:
> > git reset --hard 5fa21d821f6972e70942f2c555ec29dde962bdb2
> > 
> > That will reset the branch to the commit ID.  NOTE:  If you have local
> > changes on top, they will be wiped out.
> > 
> > There might be a way to do it without losing local changes, but I'm a
> > git idiot myself still.
> > 
> My understanding is that you are not supposed to have local changes
> on the branch you are pulling into, but have another branch for
> merging the remote tree with your own changes.

True.  But there is nothing to prevent people from doing it.  So I was
just warning them :).

josh
