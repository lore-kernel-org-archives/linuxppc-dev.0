Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0ABD1DDF42
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 01:00:46 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l63F0aMZ011802
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jul 2007 11:00:36 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l63F0WXw214786
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jul 2007 09:00:33 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l63F0Lfl005316
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jul 2007 09:00:22 -0600
Subject: Re: [PATCH v2] Schedule removal of arch/ppc
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: tgall@gentoo.org
In-Reply-To: <26d387970707030747u69ee8d2axb79452e5e1b7fa2d@mail.gmail.com>
References: <1183469146.3590.7.camel@weaponx.rchland.ibm.com>
	<26d387970707030747u69ee8d2axb79452e5e1b7fa2d@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 03 Jul 2007 10:00:20 -0500
Message-Id: <1183474821.3590.13.camel@weaponx.rchland.ibm.com>
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

On Tue, 2007-07-03 at 09:47 -0500, Tom Gall wrote:
> June 2008 is a long time away to let this linger. Why not say by End
> of the year 2007?  That should give folks essentially two more 2.6
> releases.

A year seemed like the appropriate amount of time for an arch removal.
And Segher had made a suggestion that it could be officially killed
during the PowerPC BOF at OLS 2008 for fun.  But honestly, it doesn't
matter to me.  As others have said, things can always be resurrected
from old tags if needs be.

Essentially, I'm trying to be sneaky and get Paul to declare it dead
officially.  When it actually dies, I don't care ;)

josh
