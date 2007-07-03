Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7EDD0DDE43
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 04:09:25 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l63I9LRa018078
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jul 2007 14:09:21 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l63I9IM1257464
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jul 2007 12:09:19 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l63I9EQ4031993
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jul 2007 12:09:14 -0600
Subject: Re: [PATCH v2] Schedule removal of arch/ppc
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40707031003q7d4b40dan220a8a5ac31bbc69@mail.gmail.com>
References: <1183469146.3590.7.camel@weaponx.rchland.ibm.com>
	<26d387970707030747u69ee8d2axb79452e5e1b7fa2d@mail.gmail.com>
	<fa686aa40707031003q7d4b40dan220a8a5ac31bbc69@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 03 Jul 2007 13:09:13 -0500
Message-Id: <1183486153.3590.24.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-07-03 at 11:03 -0600, Grant Likely wrote:
> On 7/3/07, Tom Gall <tgall.foo@gmail.com> wrote:
> > June 2008 is a long time away to let this linger. Why not say by End of the
> > year 2007?  That should give folks essentially two more 2.6 releases.
> 
> Please don't; us 4xx folks aren't yet ready.  Active support for
> Xilinx Virtex in arch/ppc only right now.  I want to move over to
> arch/powerpc; but end of year is rather aggressive.

Selfishly, that's why I listed it as June 2008 to begin with.  We've got
base 440 support in arch/powerpc now, but it needs more work.  And I
just started 405 this morning.

However, I definitely want some date present when arch/ppc will go away.
Otherwise it will languish on indefinitely, more so than it already has.

josh
