Return-Path: <apw@shadowen.org>
Received: from hellhawk.shadowen.org (hellhawk.shadowen.org [80.68.90.175])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CDABDDDEFF
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 01:54:41 +1000 (EST)
Message-ID: <46434041.7020903@shadowen.org>
Date: Thu, 10 May 2007 16:54:41 +0100
From: Andy Whitcroft <apw@shadowen.org>
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] update sysfs kset initialisation in PPC64 DLPAR IO	driver
References: <464322F3.3010808@shadowen.org>
	<2c705c055fcd12202673ee8a3056153b@pinky>
	<20070510141221.GA26709@suse.de>
In-Reply-To: <20070510141221.GA26709@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, paulus@samba.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Greg KH wrote:
> On Thu, May 10, 2007 at 03:00:50PM +0100, Andy Whitcroft wrote:
>> Move the rpadlpar device from "struct subsystem" to "struct kset"
>> following the changes in sysfs.
>>
>> Signed-off-by: Andy Whitcroft <apw@shadowen.org>
>> ---
>>
>> 	Ok, this patch seems to sort out the compile problem
>> 	here and indeed boots and runs kernbench.  Perhaps
>> 	you could confirm this is sufficient.
> 
> As per the discussion on the pci hotplug list, no, this doesn't seem to
> fix the problem.  The developers there are looking into it.  If you can
> test out patches for this, I'm sure the people there would appreciate
> the help.

Sure anything they have for testing, send them to me ...

-apw
