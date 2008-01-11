Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 03E62DE02F
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 12:27:11 +1100 (EST)
Date: Thu, 10 Jan 2008 19:26:41 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Mike Strosaker <strosake@austin.ibm.com>
Subject: Re: [PATCH 1/8] pseries: phyp dump: Docmentation
Message-ID: <20080111012641.GX14201@localdomain>
References: <4782C026.8080302@austin.ibm.com>
	<20080109042911.GT14201@localdomain>
	<3ae3aa420801090731r2e25e42awcae385b448e20b16@mail.gmail.com>
	<20080109184437.GU14201@localdomain>
	<3ae3aa420801091833i6cf32616o2a060579be1f3191@mail.gmail.com>
	<20080110031723.GA22168@lixom.net>
	<3ae3aa420801092012m5e47cbd7lc7a5f91842074af7@mail.gmail.com>
	<20080110162120.GA4831@lixom.net>
	<3ae3aa420801100834r6bd2750eqa7c8d29877350463@mail.gmail.com>
	<4786923E.9090902@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4786923E.9090902@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, lkessler@us.ibm.com, mahuja@us.ibm.com,
	Olof Johansson <olof@lixom.net>, linasvepstas@gmail.com,
	strosake@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mike Strosaker wrote:
> 
> At the risk of repeating what others have already said, the PHYP-assistance 
> method provides some advantages that the kexec method cannot:
>  - Availability of the system for production use before the dump data is 
> collected.  As was mentioned before, some production systems may choose not 
> to operate with the limited memory initially available after the reboot, 
> but it sure is nice to provide the option.

I'm more concerned that this design encourages the user to resume a
workload *which is almost certainly known to result in a system crash*
before collection of crash data is complete.  Maybe the gamble will
pay off most of the time, but I wouldn't want to be working support
when it doesn't.
