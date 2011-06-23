Return-Path: <benh@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0B741B6F88
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jun 2011 15:10:28 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp08.au.ibm.com (8.14.4/8.13.1) with ESMTP id p5N55CpP002781
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2011 15:05:12 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p5N59A281040636
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2011 15:09:10 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p5N5AK9u031003
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2011 15:10:20 +1000
Subject: Re: [PATCH] libata/sas: only set FROZEN flag if new EH is supported
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Brian King <brking@linux.vnet.ibm.com>
In-Reply-To: <1308804120.32158.202.camel@pasglop>
References: <20110615191747.GA6324@us.ibm.com>
	<4DF90FCA.1040706@linux.vnet.ibm.com>
	<20110615233417.GB6324@us.ibm.com>
	<20110616075114.GH8141@htj.dyndns.org>
	<4DFA0507.3090609@linux.vnet.ibm.com>
	<20110616152836.GA15268@us.ibm.com>
	<20110621160714.GA14174@us.ibm.com>
	<4E00FF58.7070802@linux.vnet.ibm.com>
	<1308803461.32158.191.camel@pasglop>
	<1308804120.32158.202.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 23 Jun 2011 15:10:17 +1000
Message-ID: <1308805817.32158.204.camel@pasglop>
Mime-Version: 1.0
Cc: jgarzik@pobox.com, wayneb@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, mbizon@freebox.fr,
	Tejun Heo <tj@kernel.org>, Nishanth Aravamudan <nacc@us.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-06-23 at 14:42 +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2011-06-23 at 14:31 +1000, Benjamin Herrenschmidt wrote:
> > On Tue, 2011-06-21 at 15:30 -0500, Brian King wrote:
> > > Looks good to me. Jeff/Tejun - any issues with merging this?
> > 
> > BTW. Current upstream with that patch applied on a machine here leads to
> > several oddities, I don't know at this point whether any of that is
> > actually a regression :
> 
> Ooops... pressed "send" too quickly. Here's a log excerpt with some
> comments:

 .../...

Ok so most of that is already in 2.6.39, including the odd LUN, so
nothing new under the sun.

I'll do more digging / bisection...

Ben.
