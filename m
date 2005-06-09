Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 6160767B42
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Jun 2005 01:20:38 +1000 (EST)
In-Reply-To: <528646bc05060907544d58da41@mail.gmail.com>
References: <528646bc05060907544d58da41@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <02ea73261175dc6bfb99047e73395fb1@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 9 Jun 2005 10:20:32 -0500
To: "Grant Likely" <glikely@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC52xx: sysfs failure on adding new device driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>> That changes the semantic of the driver names for the platform bus
>> however, making the dot a "special" char.
> Who needs to be asked about this?  Should I take this discussion over
> the the LKML?

GregKH would be the person to talk to about the driver core and taking 
this to LKML would be useful.  We probably have a similar issue with 
CPM comm channels.

I always assumed multiple drivers would get probed and the drivers 
would fail in probe if they were not suppose to bind to the given 
channel/psc, etc..

- kumar
