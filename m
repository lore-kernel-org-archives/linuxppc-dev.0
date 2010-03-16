Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EC33CB7D9D
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Mar 2010 01:39:28 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o2GEbtha031728
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Mar 2010 08:37:55 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o2GEdKDm198968
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Mar 2010 08:39:21 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o2GEd8jj005429
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Mar 2010 08:39:09 -0600
Date: Tue, 16 Mar 2010 10:39:03 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Goodenough <david.goodenough@btconnect.com>
Subject: Re: Can the OpenRB board descriptions be merged into the mainline
	kernel?
Message-ID: <20100316143903.GK8963@zod.rchland.ibm.com>
References: <201003161223.19238.david.goodenough@btconnect.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201003161223.19238.david.goodenough@btconnect.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 16, 2010 at 12:23:19PM +0000, David Goodenough wrote:
>OpenWRT has some fixes which adds the board descriptions for the OpenRB
>(ppc504 based boards).  Is there any reason why these should not be

ppc504?  I've not heard of that one.  Is that a typo for 405?

>merged into the mainline kernel?  The fixes are all licences GPL2.
>
>If not do you want the original authors to submit them, or shall I take the
>OpenWRT specific bits out and post them here?

What exactly do you mean by "board description"?

josh
