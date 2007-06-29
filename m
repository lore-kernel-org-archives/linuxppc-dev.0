Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CD5F4DDF99
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Jun 2007 01:32:37 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5TFWZQS005365
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 11:32:35 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l5TFWYaE204608
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 09:32:34 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l5TFWYIr016981
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 09:32:34 -0600
Subject: Re: [PATCH v2] dtc: Add install makefile target
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <jehcoqsrzw.fsf@sykes.suse.de>
References: <1183128803.30145.29.camel@weaponx.rchland.ibm.com>
	<jehcoqsrzw.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Fri, 29 Jun 2007 10:32:33 -0500
Message-Id: <1183131153.30145.36.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-06-29 at 17:24 +0200, Andreas Schwab wrote:
> Josh Boyer <jwboyer@linux.vnet.ibm.com> writes:
> 
> > +install: dtc ftdump
> > +	$(INSTALL) -d $(DESTDIR)/$(BINDIR)
> > +	$(INSTALL) -m 755 dtc $(DESTDIR)/$(BINDIR)
> > +	$(INSTALL) -m 755 ftdump $(DESTDIR)/$(BINDIR)
> 
> Don't put a slash after $(DESTDIR).  You'll end up with a doulbe slash.

/me bangs head on desk.

Why is it that the 9 line patches are always the most screwed up ones?
I'll fix it again.  Maybe after more coffee.

josh
