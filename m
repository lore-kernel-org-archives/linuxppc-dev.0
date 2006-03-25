Return-Path: <dwm@maxeymade.com>
Received: from falcon30.maxeymade.com (falcon30.maxeymade.com [24.173.215.190])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.maxeymade.com",
	Issuer "ChainedSSL Certificate Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 818A567A39
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Mar 2006 10:15:21 +1100 (EST)
Message-Id: <200603252227.k2PMRJ57026730@falcon30.maxeymade.com>
In-reply-to: <1142976221.2751.22.camel@enki.eridu> 
To: Paul Nasrat <pnasrat@redhat.com>
Subject: Re: [PATCH] powerpc: Add FSL SEC node to documentation 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 25 Mar 2006 16:27:19 -0600
From: Doug Maxey <dwm@maxeymade.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 21 Mar 2006 16:23:41 EST, Paul Nasrat wrote:
>On Tue, 2006-03-21 at 13:28 -0600, Hollis Blanchard wrote:
>> On Tue, 2006-03-21 at 12:25 -0600, Kumar Gala wrote:
>> > On Mar 20, 2006, at 8:14 PM, Hollis Blanchard wrote:
>
>> > > Have you consulted with any other vendors regarding these  
>> > > properties? I know
>> > > there is no IEEE1275 binding for these sorts of devices, but we can  
>> > > at least
>> > > attempt to standardize it (even in the absence of the Open Firmware  
>> > > Working
>> > > Group)...
>> > 
>> > Beyond the device_type, I'm not sure if there is much more one could  
>> > standardize one.  The other fields that Kim spec'd are either generic  
>> > OF fields (reg, interrupts, etc.) or specific to the Freescale devices.
>> 
>> The device_type and compatible properties are exactly what I'm talking
>> about.
>
>The Working Group lists still exist but are pretty dead.  I agree we
>really want to ensure that both OF based and dtc based new hardware is
>consistent.  I'm not sure how we want to do this, but we can document in
>Documentation and then use eg SLOF to mock out the OF interfaces and
>create proposals and kick some life into the OF working group.  

Sorry for the delayed reply, my procmail filter was pumping mails to
the old list name without telling me. :)

Other than IBM, Motorola, and possibly Sun, what groups are using 
OFW on new platforms anymore?  

Power.org may be a vehicle to publish.  

The Power TSC leader indicated a willingness to look into a process to 
get out some purely internal bindings (at the moment) that _really_ 
need some fresh air to flourish.

++doug
