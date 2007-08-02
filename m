Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 84709DDDF4
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 08:53:42 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l72Mrci0014489
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 18:53:38 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l72MrcFX531222
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 18:53:38 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l72Mrb9I026485
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 18:53:38 -0400
Date: Thu, 2 Aug 2007 17:53:37 -0500
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH]: PCI Error Recovery: Symbios SCSI device driver
Message-ID: <20070802225337.GK26837@austin.ibm.com>
References: <20070702183917.GJ4501@austin.ibm.com>
	<20070705112838.2d8c959b.akpm@linux-foundation.org>
	<20070705185406.GA3527@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070705185406.GA3527@parisc-linux.org>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: James.Bottomley@steeleye.com, linux-scsi@vger.kernel.org, willy@debian.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 05, 2007 at 12:54:06PM -0600, Matthew Wilcox wrote:
> On Thu, Jul 05, 2007 at 11:28:38AM -0700, Andrew Morton wrote:
> > Well you've sent it a couple of times, and I've sent it in five more times
> > over the past year.  Once we were told "awaiting maintainer ack".
> > 
> > This situation is fairly stupid.  How about we make you the maintainer?
> 
> Last time I looked at it, I still wasn't comfortable with it.  I'm going
> to look at it again.

Please do. Its burning the proverbial hole in my pocket; I'd really
like to get this off my list of things I worry about.

> I'm fairly sure Linas doesn't want to be the sym2 maintainer.  It's
> still an ugly pile of junk that needs cleaning up.

Heh. I have no difficulty living with ugly code: its actually a 
great excuse to fix things instead of doing "real work" :-)

Rather, the menagerie of hardware I have access to is constantly 
changing; I don't have a symbios card just right now, and it might 
take a few days to even find someone who did.  Which is an incredibly
unpleasent, unrewarding activity.

--linas
