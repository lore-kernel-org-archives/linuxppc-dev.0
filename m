Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6F764DDF4F
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Jun 2007 01:13:39 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5TFDaEG009567
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 11:13:36 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l5TFDX4e235334
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 09:13:34 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l5TFDVUH013298
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 09:13:32 -0600
Subject: Re: [PATCH] Schedule removal of arch/ppc
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1183128867.1170.341.camel@pmac.infradead.org>
References: <1182952173.9889.4.camel@weaponx.rchland.ibm.com>
	<1183128867.1170.341.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Fri, 29 Jun 2007 10:13:31 -0500
Message-Id: <1183130011.30145.35.camel@weaponx.rchland.ibm.com>
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

On Fri, 2007-06-29 at 15:54 +0100, David Woodhouse wrote:
> On Wed, 2007-06-27 at 08:49 -0500, Josh Boyer wrote:
> > +      remain in bug-fix only mode until it's scheduled removal.  Platforms
> 
> http://www.angryflower.com/itsits.gif

That's it?  I'm scheduling the demise of an entire architecture sub-tree
and the only comment you can make is about a superfluous apostrophe? ;)

Anyway, I'll fix it after waiting a bit more to see if anyone has
further comments.

josh
