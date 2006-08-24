Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F34EE67D75
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Aug 2006 04:25:12 +1000 (EST)
In-Reply-To: <1156430695.17977.28.camel@saruman.qstreams.net>
References: <1156371402.17977.21.camel@saruman.qstreams.net>
	<AB150E9C-6BB3-46C1-980D-311D3277BFC1@kernel.crashing.org>
	<1156430695.17977.28.camel@saruman.qstreams.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9861097B-ACAD-45E6-9FA7-B86F0C1E8FA1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: CompactFlash on PQII Pro
Date: Thu, 24 Aug 2006 13:25:06 -0500
To: bwarren@qstreams.com
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


On Aug 24, 2006, at 9:44 AM, Ben Warren wrote:

> Thanks Kumar,
>
> As always, you're several steps ahead of me.
>
> On Wed, 2006-08-23 at 18:04 -0500, Kumar Gala wrote:
>
>> I know I posted a patch for cf-ide.c to lkml some time ago, this was
>> to do a CF in true ide mode using the 83xx localbus.
>>
>> http://marc.theaimsgroup.com/?l=linux-kernel&m=113877891224982&w=2
>>
>> We did some UPM setup in u-boot to use two CS on Localbus for this.
> In our case, we only have one CS available but it's going to a CPLD  
> that
> will decode and provide two CSs to the CF.  This will work as long as
> the UPM setup is identical for the two chip selects.  Should be...
> Off-topic to this list, but do you have the U-boot code that you can
> share?  If not, no worries.

The only code in u-boot was the UPM setup code, I'm happy to send  
that to you.

- kumar
