Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (71-36-219-11.roch.qwest.net [71.36.219.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A1AD967B48
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jun 2006 05:10:45 +1000 (EST)
Subject: Re: "merge" branch reset in powerpc.git tree
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Dave C Boutcher <boutcher@cs.umn.edu>
In-Reply-To: <17564.6980.694265.974713@hound.rchland.ibm.com>
References: <17563.54330.600099.894958@cargo.ozlabs.ibm.com>
	<17564.6980.694265.974713@hound.rchland.ibm.com>
Content-Type: text/plain
Date: Fri, 23 Jun 2006 14:10:24 -0500
Message-Id: <1151089824.22158.2.camel@weaponx.rchland.ibm.com>
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

On Fri, 2006-06-23 at 11:48 -0500, Dave C Boutcher wrote:
> On Fri, 23 Jun 2006 21:44:58 +1000, Paul Mackerras <paulus@samba.org> said:
> > 
> > If you are following the powerpc.git tree, and you pull the "merge"
> > branch, you will need to reset it to have commit ID
> > 5fa21d821f6972e70942f2c555ec29dde962bdb2 as its head.  That's also the
> > head of the "master" branch and of Linus' linux-2.6 tree at the
> > moment.
> 
> At risk of appearing like a git ignoramous...could you post the
> command to perform such a reset?

Run the following in that branch:

git reset --hard 5fa21d821f6972e70942f2c555ec29dde962bdb2

That will reset the branch to the commit ID.  NOTE:  If you have local
changes on top, they will be wiped out.

There might be a way to do it without losing local changes, but I'm a
git idiot myself still.

josh
