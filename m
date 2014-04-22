Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0238.outbound.protection.outlook.com [207.46.163.238])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7306C1400FA
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2014 08:37:13 +1000 (EST)
Message-ID: <1398206224.1694.254.camel@snotra.buserror.net>
Subject: Re: questions on CONFIG_PPC_ADV_DEBUG_REGS, DBCR0_BRT, and
 DBCR0_ACTIVE_EVENTS
From: Scott Wood <scottwood@freescale.com>
To: shiva7 <sivasakthi7@outlook.com>
Date: Tue, 22 Apr 2014 17:37:04 -0500
In-Reply-To: <1398205896.1694.252.camel@snotra.buserror.net>
References: <5167457E.1050205@genband.com>
 <1398170592855-81732.post@n7.nabble.com>
 <1398205896.1694.252.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Chris Friesen <chris.friesen@genband.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-04-22 at 17:31 -0500, Scott Wood wrote:
> On Tue, 2014-04-22 at 05:43 -0700, shiva7 wrote:
> > I have the same question as like above posted by Mr. Chirs. 
> 
> I had to google the subject to find what e-mail you were talking about
> -- it was posted a year ago:
> 
> http://marc.info/?l=linuxppc-embedded&m=136572252330650&w=2
> 
> Next time please quote the e-mail if you're trying to revive a thread,
> and keep the original poster on CC.
> 
> I've quoted it here:
> 
> > Sorry for the bunch of emails, I'm working on some new stuff and running 
> > into issues.
> > 
> > For CONFIG_BOOKE it appears that DBCR0_ACTIVE_EVENTS includes DBCR0_ICMP 
> > but not DBCR0_BRT.  Is that just because none of the code paths 
> > currently using DBCR0_ACTIVE_EVENTS need to check DBCR0_BT?
> 
> Perhaps it was just an oversight.  I've CCed Dave Kleikamp and Torez
> Smith, who added DBCR0_ACTIVE_EVENTS.

...and both of those e-mails bounced, so it may be that nobody who is
listening knows the answer.  Feel free to submit a patch that adds it,
with the changelog explaining why it should be included.

-Scott
