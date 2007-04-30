Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound8-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 60523DDF97
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 01:49:40 +1000 (EST)
Message-ID: <4636100C.7020006@am.sony.com>
Date: Mon, 30 Apr 2007 08:49:32 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH 13/14] powerpc: add ps3 platform system bus support
References: <4563D02F.9010307@am.sony.com> <20070430104714.GA25815@aepfle.de>
In-Reply-To: <20070430104714.GA25815@aepfle.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering wrote:
> On Tue, Nov 21, Geoff Levand wrote:
> 
>> Adds a PS3 system bus driver.  This system bus is a virtual bus used to present
>> the PS3 system devices in the LDM.
> 
> What is the benefit of yet another bus?

We need a bus to abstract the MMIO, DMA and interrupt specifics of
the hypervisor.

> Can those 3 drivers be platform devices instead?

It is my understanding that the platform bus was made to
support legacy code.

We plan to put all the devices on the system bus.  That work
is now in progress.

> The generated modalias files do not match anything.
 
Module support is still todo.  I am just now started on it.  David
Woodhouse sent a few patches, but I just merged them in without
testing.

-Geoff
