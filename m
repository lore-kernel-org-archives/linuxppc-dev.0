Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7B28467B56
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Aug 2006 05:14:50 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e2.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6VJEjrt008450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Jul 2006 15:14:46 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6VJ6Gkc275330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Jul 2006 13:13:04 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6VIv300027883
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Jul 2006 12:57:03 -0600
Date: Mon, 31 Jul 2006 13:57:02 -0500
To: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] remove bogomips from /proc/cpuinfo
Message-ID: <20060731185702.GF4453@austin.ibm.com>
References: <20060731125904.GA1997@suse.de>
	<200607311946.18331.arnd.bergmann@de.ibm.com>
	<20060731174924.GA4273@suse.de> <jewt9tfxlq.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <jewt9tfxlq.fsf@sykes.suse.de>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Paul Mackeras <paulus@samba.org>,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>, Olaf Hering <olh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 31, 2006 at 08:17:05PM +0200, Andreas Schwab wrote:
> Olaf Hering <olh@suse.de> writes:
> 
> >  On Mon, Jul 31, Arnd Bergmann wrote:
> >
> >> On Monday 31 July 2006 14:59, Olaf Hering wrote:
> >> > Remove bogomips from /proc/cpuinfo.
> >> > It is now really bogus since "timebase-frequency" is shown.
> >> 
> >> Well, but it's still part of the ABI, right?
> >> How do you determine that there are no broken applications
> >> still relying on it?
> >
> > Everything works on a G5, as example. Alpha doesnt have it either.
> > What pratical value had bogomips for an application?
> 
> What harm does it do?

Kernel bloat.

--linas
