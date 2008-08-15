Return-Path: <DWatkins@tranzeo.com>
Received: from mail.tranzeo.com (isa.tranzeo.com [64.114.87.10])
	by ozlabs.org (Postfix) with ESMTP id DA2DFDDF96
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Aug 2008 06:38:12 +1000 (EST)
Subject: Re: Possible init bug in ibm_newemac/core.c
From: Darcy Watkins <dwatkins@tranzeo.com>
To: Benjamin Krill <ben@codiert.org>
In-Reply-To: <1218830440.3465.201.camel@localhost>
References: <1218819785.3465.190.camel@localhost>
	<20080815174821.GK10829@codiert.org>
	<1218830440.3465.201.camel@localhost>
Content-Type: text/plain
Date: Fri, 15 Aug 2008 13:38:11 -0700
Message-Id: <1218832691.3465.205.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Good news!  The patch in the URL is what I tried earlier (as mentioned
below).  The one in the followup post on the thread - I didn't try,
until now.  It appears to work properly on both boards.

Cheers and Thanks!

On Fri, 2008-08-15 at 13:00 -0700, Darcy Watkins wrote:
> --snip!-- What they did was exactly what I
> did (and then later reverted).  
--snip!--

> On Fri, 2008-08-15 at 10:48 -0700, Benjamin Krill wrote:
--snip!--
> > Have a look at thread:
> > http://ozlabs.org/pipermail/linuxppc-dev/2008-August/061631.html
--snip!--
-- 


Regards,

Darcy

--------------
Darcy L. Watkins - Senior Software Developer
Tranzeo Wireless Technologies, Inc.
19273 Fraser Way, Pitt Meadows, BC, Canada V3Y 2V4
T:604-460-6002 ext:410
http://www.tranzeo.com
