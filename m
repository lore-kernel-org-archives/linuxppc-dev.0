Return-Path: <CFRIESEN@nortel.com>
Received: from zcars04e.nortel.com (zcars04e.nortel.com [47.129.242.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 1A750DDD01
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jun 2009 06:28:40 +1000 (EST)
Message-ID: <4A258B6D.6050006@nortel.com>
Date: Tue, 02 Jun 2009 14:28:29 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: wael showair <showair2003@yahoo.com>
Subject: Re: is the resolution of do_gettimeofday in usec?
References: <23807779.post@talk.nabble.com>
In-Reply-To: <23807779.post@talk.nabble.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

wael showair wrote:
> Hi All,
> i have board that contains MPC8555 processor with linux 2.6.27 ported to it.
> i want to use an accurate function to measure the time. i searched the
> kernel code & i found several functions but i read that the do_gettimeofday
> is the most accurate one since it has a timer resolution of usec.

You might also look at clock_gettime(), which has a theoretical accuracy
of nanoseconds.  Both this and gettimeofday are NTP-corrected if you are
synced to an NTP clock.

> my question is how this function give this accuracy while the kernel timer
> is 4msec?

The accuracy of the timestamp is not related to the tick interval.

Chris
