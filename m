Return-Path: <rdreier@cisco.com>
Received: from sj-iport-4.cisco.com (sj-iport-4.cisco.com [171.68.10.86])
	by ozlabs.org (Postfix) with ESMTP id 2B755DDEA2
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 10:13:00 +1000 (EST)
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH] Change 440GP platform to ppc440
References: <Pine.LNX.4.64.0704191615040.25069@localhost.localdomain>
	<17961.22721.462194.785356@cargo.ozlabs.ibm.com>
	<CE31BB28-E702-4425-A266-9D5D143A53DC@kernel.crashing.org>
	<20070424000153.GD23995@crusty.rchland.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 23 Apr 2007 17:12:58 -0700
In-Reply-To: <20070424000153.GD23995@crusty.rchland.ibm.com> (Josh Boyer's
	message of "Mon, 23 Apr 2007 19:01:54 -0500")
Message-ID: <ada647m635h.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > I recall dimly that there was some user-visible difference between the
> > 440GP and the other 440 processors, and that's why we made the
> > platform string different.  I don't recall what the difference was.

FWIW, I've run the same userspace (binaries) on 405GPr, 440GP and
440SPe without any problems.  Not that I'm a 4xx expert by any
stretch, but I don't know of anything special about the 440GP.

 - R.
