Return-Path: <ncase@xes-inc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1D17DB7149
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 02:08:05 +1000 (EST)
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 314C6DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 02:08:03 +1000 (EST)
Subject: Re: System clock systems to be twice as fast as RTC
From: Nate Case <ncase@xes-inc.com>
To: Subodh Nijsure <sunijsur@cisco.com>
In-Reply-To: <008701c9eaa7$3c8336c0$8dde520a@cisco.com>
References: <008701c9eaa7$3c8336c0$8dde520a@cisco.com>
Content-Type: text/plain
Date: Thu, 11 Jun 2009 11:07:54 -0500
Message-Id: <1244736474.29684.1643.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-06-11 at 08:13 -0700, Subodh Nijsure wrote:
> The system clock seems to be running twice as as fast as RTC, 
> 
> sh-2.05b# date ; sleep 60 ; date
> Fri Sep 11 01:37:11 UTC 1970
> Fri Sep 11 01:37:41 UTC 1970

That's strange, but note that "date" reads the system clock and not the
RTC.  Use "hwclock" for the RTC.

-- 
Nate Case <ncase@xes-inc.com>
