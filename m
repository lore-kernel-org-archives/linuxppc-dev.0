Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7F0ABDDE0C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 06:21:42 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l72KLdLk001093
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 16:21:39 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l72KLdK9159916
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 14:21:39 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l72KLcnr024994
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 14:21:38 -0600
Date: Thu, 2 Aug 2007 15:21:34 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 3/6] PowerPC 440EPx: 440EPx/440EP dcr defines
Message-ID: <20070802152134.1c6a28bf@weaponx.rchland.ibm.com>
In-Reply-To: <20070801020936.GC31391@localhost.localdomain>
References: <20070730151245.GA5027@ru.mvista.com>
	<20070801020936.GC31391@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 1 Aug 2007 12:09:36 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Mon, Jul 30, 2007 at 07:12:45PM +0400, Valentine Barshak wrote:
> > This patch adds DCR defines needed for 440EP/440EPx clock
> > initialization. These defines have been introduced in the Bamboo
> > support by Josh Boyer and are needed for Sequoia as well.
> 
> These should really go in the same patch that uses them.  I dislike
> this business of splitting patches up when the parts are functionally
> dependent on each other.

Yeah.  We have a small race here anyway, since two different patch sets
need this but are currently not depending as such.  E.g. Bamboo or
Sequoia should be first, and the other should be patches after that
series.

josh
