Return-Path: <acurtis@onz.com>
Received: from dell2650.onz.com (onz.com [67.121.61.113])
	by ozlabs.org (Postfix) with ESMTP id ED389679E7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Jun 2005 06:07:50 +1000 (EST)
In-Reply-To: <33f285d9677314c043e77908198a3e0e@embeddededge.com>
References: <ecc06b51023e6ebd23d075aa3948749e@onz.com>
	<33f285d9677314c043e77908198a3e0e@embeddededge.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b2f31907a6e9a9180a96318ceeacb468@onz.com>
From: Allen Curtis <acurtis@onz.com>
Date: Thu, 16 Jun 2005 13:07:47 -0700
To: Dan Malek <dan@embeddededge.com>
Cc: Ppc Embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: RFC cpm2_devices DPRAM resource
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>> Should the DPRAM appear as it's own platform_device?
>
> No.
>
>> Option 1) Specify the portion of the DPRAM used by each device with 
>> that platform_device definition. (current)
>
> You mean the parameter space?  That's different from DPRAM.
>
>> Option 2) Define the whole DPRAM region as its own platform_device 
>> entry. Move the device DPRAM information to the device specific 
>> platform structure.
>
> How is this any different from using the dpalloc() as it is today?
>
> The problem is that for the few standard devices we publicly support in
> Linux it is easy to think of DPRAM as a "general" resource.  However, 
> for
> more challenging devices and implementation, there are sometimes 
> specific
> regions of DPRAM that must be used with various additional 
> restrictions.
> For many of the "real world" devices I have done, drivers would manage
> their own, well known, DPRAM areas.  It isn't something that is easy
> to generalize or configure in advance.
>
Time for code.

- Allen
