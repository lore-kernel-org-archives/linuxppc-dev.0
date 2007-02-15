Return-Path: <bwarren@qstreams.com>
Received: from smtp106.biz.mail.re2.yahoo.com (smtp106.biz.mail.re2.yahoo.com
	[206.190.52.175]) by ozlabs.org (Postfix) with SMTP id 7A24DDDF82
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Feb 2007 03:07:41 +1100 (EST)
Subject: Re: CLI for embedded system
From: Ben Warren <bwarren@qstreams.com>
To: pjmaiya <pjmaiya@signal-networks.com>
In-Reply-To: <01a901c750f5$ef392de0$4601a8c0@signet>
References: <29DC34A6B43468409F5A371CFE34E849091044@ex01.ads.ubidyne.de>
	<011b01c74b81$5604ad80$4601a8c0@signet>
	<1170949359.14627.66.camel@saruman.qstreams.net>
	<00c401c74c36$42aeded0$4601a8c0@signet>
	<01a901c750f5$ef392de0$4601a8c0@signet>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 11:07:38 -0500
Message-Id: <1171555658.7029.49.camel@saruman.qstreams.net>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2007-02-15 at 17:09 +0530, pjmaiya wrote:
> hi,
>     I have successfully complied and used 'clish' in host system (i686
> machine)
> But I need to port the same for PPC platform. Can anyone suggest me how to
> do the same.
> 
> thanx in advace,
> pjmaiya
> 

Like many other projects, I believe this one uses autoconf (I think
that's the term).  As a starting point, try:

host$ ./configure --host=ppc-linux-gnu --build=i686 CC=
${CROSS_COMPILE}gcc

/* Monitor the output of configure to make sure that everything looks
kosher.  You'll probably want to add a "--prefix=" option that tells it
where to place the end result, and there may be other options you want
too.  Read and understand the Makefile that configure creates.  Then:

host$ make

I reiterate - this is only a starting point.  This may not compile
cleanly and you will need to experiment a bit, I'm sure.  Hopefully it's
not too bad, but these projects can sometimes be a pain to get exactly
as you want.

regards,
Ben
