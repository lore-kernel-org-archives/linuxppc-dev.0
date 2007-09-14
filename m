Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7B473DDE1E
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 05:09:51 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8EJ9mUe007475
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 15:09:48 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8EJ9mpO475592
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 13:09:48 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8EJ9mA0016475
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 13:09:48 -0600
Date: Fri, 14 Sep 2007 14:09:46 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [patch 0/4] Small 4xx updates for 2.6.24
Message-ID: <20070914140946.25bbd0d3@weaponx.rchland.ibm.com>
In-Reply-To: <20070914135914.4037a5cb@weaponx.rchland.ibm.com>
References: <20070914135914.4037a5cb@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 14 Sep 2007 13:59:14 -0500
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> Below is a small update series for 4xx that I intend to put in my
> 2.6.24 branch soon and send to Paul.  It contains an already acked
> cuboot wrapper for Bamboo, a fix for the newly updated physmap_of
> driver, and updates to the walnut and sequoia flash nodes in the DTS
> files.

Ignore this particular email.  I had two mailers competing to send out
patches and couldn't kill one of them before this got out.  The other
one with the patches actually following it is the right one :)

josh
