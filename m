Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B357D67B3B
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 May 2006 05:49:54 +1000 (EST)
In-Reply-To: <1628E43D99629C46988BE46087A3FBB9546A40@ep-01.EmbeddedPlanet.local>
References: <1628E43D99629C46988BE46087A3FBB9546A40@ep-01.EmbeddedPlanet.local>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1EE33113-ACEC-424C-8ECD-B6F4BA66AA5E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: USB on MPC8349EMDS
Date: Tue, 2 May 2006 14:49:44 -0500
To: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 2, 2006, at 2:26 PM, Steven Blakeslee wrote:

>>
>> / #  usb 1-2: new high speed USB device using fsl-usb2-mph
>> and address 8 usb 1-2: khubd timed out on ep0in usb 1-2: new
>> high speed USB device using fsl-usb2-mph and address 9 usb
>> 1-2: khubd timed out on ep0in
>>
>
> When I used that driver I found it only worked with Full speed  
> devices.
> Low and High speed devices did not work.

Yeah, that was due to the bug in the driver if my memory serves me  
correctly.

- k
