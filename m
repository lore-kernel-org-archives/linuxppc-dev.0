Return-Path: <bwarren@qstreams.com>
Received: from smtp101.biz.mail.re2.yahoo.com (smtp101.biz.mail.re2.yahoo.com
	[68.142.229.215]) by ozlabs.org (Postfix) with SMTP id 0148FDDD0D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Feb 2007 02:29:16 +1100 (EST)
Subject: Re: CLI for embedded system
From: Ben Warren <bwarren@qstreams.com>
To: pjmaiya <pjmaiya@signal-networks.com>
In-Reply-To: <000d01c755ae$364a7bf0$4601a8c0@signet>
References: <29DC34A6B43468409F5A371CFE34E849091044@ex01.ads.ubidyne.de>
	<011b01c74b81$5604ad80$4601a8c0@signet>
	<1170949359.14627.66.camel@saruman.qstreams.net>
	<00c401c74c36$42aeded0$4601a8c0@signet>
	<01a901c750f5$ef392de0$4601a8c0@signet>
	<1171555658.7029.49.camel@saruman.qstreams.net>
	<000d01c755ae$364a7bf0$4601a8c0@signet>
Content-Type: text/plain
Date: Wed, 21 Feb 2007 10:29:13 -0500
Message-Id: <1172071753.22834.87.camel@saruman.qstreams.net>
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

On Wed, 2007-02-21 at 17:18 +0530, pjmaiya wrote:
> Dear Ben,
>      I have tried following option, with host as ppc_8xx, since we are using
> mpc860 processor and  also we are using montavista provided compiler
> (ppc_8xx).
> Our embedded target runs on montavista linux with mpc860 processor and
> compiler given by monta vista(hard hat linux).
> 
> host$ ./configure --host=ppc_8xx --build=i686 CC=ppc_8xx-gcc
> 
> We are getting error ppc_8xx unkown host at some stage. When we further
> investigated "clish" code we found that we need to add our new architecture
> in aux_scripts/configure.sub file. We have successfully built that part. But
> for some libarary we are getting error in /usr/lib/libbstd++, but we need to
> change this path..only option left for us to change in "configure" file
> which requires autoconf tool..Also we need to change some thing in
> "configure.in". We are little bit stuck in this part..Can U help in this
> regard.. Writing our make for clish is massive work!!!

I really doubt you need to mess with any of these files.  Have you tried
the host parameter that I suggested (--host=ppc-linux-gnu)?  I believe
that worked for me, but it's been a while.  

Unfortunately I can't spare any time on this right now.  Have you
checked to see if there's a mailing list for the clish project?  I
imagine building this for a 32-bit PowerPC has been done before many
times over.

regards,
Ben
