Return-Path: <joe@perches.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 108351A06BA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 14:42:33 +1100 (AEDT)
Received: from smtprelay.hostedemail.com (smtprelay0083.hostedemail.com
 [216.40.44.83])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B77DC1402C4
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Mar 2016 14:42:32 +1100 (AEDT)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave08.hostedemail.com (Postfix) with ESMTP id 5FEB92119E9
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Mar 2016 03:33:10 +0000 (UTC)
Message-ID: <1456889582.4436.43.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Add powerpc drivers to the powerpc section
From: Joe Perches <joe@perches.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Joel Stanley <joel@jms.id.au>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Date: Tue, 01 Mar 2016 19:33:02 -0800
In-Reply-To: <1456888343.24490.8.camel@ellerman.id.au>
References: <1456882616-26811-1-git-send-email-mpe@ellerman.id.au>
 <CACPK8Xe+vxJe-ArTP7ZU4gKjJtZwviT0t9h7kS1R1WvW6E-msA@mail.gmail.com>
 <1456888343.24490.8.camel@ellerman.id.au>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-03-02 at 14:12 +1100, Michael Ellerman wrote:
> On Wed, 2016-03-02 at 12:20 +1030, Joel Stanley wrote:
> 
> > 
> > On Wed, Mar 2, 2016 at 12:06 PM, Michael Ellerman  wrote:
> > 
> > > 
> > > We'd like folks working on drivers for powerpc to also Cc linuxppc-dev,
> > > so we can be aware of what's going on in drivers and/or review the
> > > changes.
> > > 
> > > So add patterns to the powerpc MAINTAINERS section to catch some of the
> > > drivers we're interested in.
> > There are a few more that would be good. '*opal*.c' catches these:
> > 
> > ./drivers/i2c/busses/i2c-opal.c
> > ./drivers/rtc/rtc-opal.c
> > ./drivers/tty/hvc/hvc_opal.c
> Ah yep thanks, will add "N: opal".

N: and F: have different characteristics for get_maintainer.pl

>From MAINTAINERS:

	   scripts/get_maintainer.pl has different behavior for files that
	   match F: pattern and matches of N: patterns.  By default,
	   get_maintainer will not look at git log history when an F: pattern
	   match occurs.  When an N: match occurs, git log history is used
	   to also notify the people that have git commit signatures.
