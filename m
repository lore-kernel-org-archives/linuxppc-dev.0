Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-va3-R.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 436DFDDE26
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 13:19:44 +1100 (EST)
Message-ID: <47C76BBA.5000503@am.sony.com>
Date: Thu, 28 Feb 2008 18:19:38 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH 0/3] hotplug memory remove updates
References: <1204217028.28696.10.camel@dyn9047017100.beaverton.ibm.com>
	<20080229013957.GQ16241@localdomain>
In-Reply-To: <20080229013957.GQ16241@localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Badari Pulavarty <pbadari@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi.

Nathan Lynch wrote:
> Badari Pulavarty wrote:
>> Hi Paul,
>> 
>> Here are the hotplug memory remove updates for 2.6.25-rc2-mm1.
> 
> How have these been tested?  Have you initiated a memory remove
> operation from the HMC?  That's the only way to catch some bugs...

I'm wondering how the memory hot un-plug is initiated on the pseries.
Could you tell me about this HMC?  Is it an application running in
the lpar, or is it an external entity?

Is there a 'standard' interface from userspace that can be used to
trigger the hot-unplug sequence?  I'm asking because PS3's lv1
hypervisor supports hot un-plug of memory, but it would need to be
triggered from some kind of management application running in in
userspace.

-Geoff
