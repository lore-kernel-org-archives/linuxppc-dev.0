Return-Path: <linas@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BE895DDE33
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 07:58:17 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0AKwEIL016736
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 15:58:14 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	l0AKwEOH285752
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 15:58:14 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l0AKwEkA023306
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 15:58:14 -0500
Date: Wed, 10 Jan 2007 14:58:12 -0600
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH]Enabling Auto poweron after power is restored.
Message-ID: <20070110205812.GA6177@austin.ibm.com>
References: <45707469.9060604@austin.ibm.com> <4575E76C.7030300@austin.ibm.com>
	<17785.415.574041.518517@cargo.ozlabs.ibm.com>
	<458EBE02.3010401@austin.ibm.com>
	<17827.5922.667200.166153@cargo.ozlabs.ibm.com>
	<20070109150519.GD8122@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070109150519.GD8122@localdomain>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 09, 2007 at 09:05:19AM -0600, Nathan Lynch wrote:
> Paul Mackerras wrote:
> > Manish Ahuja writes:
> > 
> > > During power outages, the ups notifies the system for a shutdown. In the 
> > > current setup, it isn't possible to power on when power is restored. 
> > > This patch fixes the issue by calling the right ibm,power-off-ups token 
> > > during such events. It also adds a proc interface so that rc.powerfail 
> > > can parse the epow events and modify the power-off behavior accordingly 
> > > to enable the right token to be called.
> > 
> > Creating new non-process-related files in /proc is frowned upon these
> > days, so we'll have to find somewhere in /sys for this.  Anybody got a
> > suggestion?
> 
> Maybe a sysctl instead?

What's a sysctl?

Create a new /sys/class/rtas class? 
There's a suggestive /sys/firmware directory, but  don't know why its
there... 

-- linas
