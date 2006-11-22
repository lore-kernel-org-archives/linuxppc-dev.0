Return-Path: <mjw@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1D2CF67C4F
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 06:42:34 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAMJgVe7029599
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 14:42:31 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAMJgVT2503168
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 12:42:31 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAMJgVW2004105
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 12:42:31 -0700
Received: from wecm-9-67-39-53.wecm.ibm.com (wecm-9-67-39-53.wecm.ibm.com
	[9.67.39.53])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	kAMJgUI5004059
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 12:42:30 -0700
Subject: Re: [PATCH] powerpc: Make 970MP detectable by oprofile
From: Mike Wolf <mjw@us.ibm.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <20061122130507.477dfe2c@pb15>
References: <1164141715.9752.5.camel@localhost>
	<1164214098.5704.1.camel@localhost>  <20061122130507.477dfe2c@pb15>
Content-Type: text/plain
Date: Wed, 22 Nov 2006 13:42:28 -0600
Message-Id: <1164224548.2769.4.camel@localhost>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-11-22 at 13:05 -0600, Olof Johansson wrote:
> On Wed, 22 Nov 2006 10:48:18 -0600 Mike Wolf <mjw@us.ibm.com> wrote:
> 
> > >Just out of curiosity, what are those?  I never saw any,
> > >but I'd love to know :-)
> >
> >
> > They are the IBM JS21 blades
> 
> I think Segher might have had "what are the new counters" in mind when he asked that, not where the processors are used. :-)
> 
> 
> -Olof

They are different MMCRx settings for counting certain events.

Mike
