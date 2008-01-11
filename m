Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id EE463DDF43
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 17:19:28 +1100 (EST)
Message-ID: <47870A6F.2040101@pikatech.com>
Date: Fri, 11 Jan 2008 01:19:27 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: ibm4xx_quiesce_eth?
References: <47866614.3010203@pikatech.com>
	<20080110122427.59102355@zod.rchland.ibm.com>
	<200801110715.00058.sr@denx.de>
In-Reply-To: <200801110715.00058.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Roese wrote:
>> There are firmwares that do not reset the EMAC and MAL before passing
>> control to the client program (Linux in our case).  This can cause
>> weird things to happen, like spurious interrupts or DMAs from the
>> hardware overwriting kernel memory.  So we quiesce the hardware really
>> early on those.
>>
>> I don't believe U-Boot has that problem.  If it does, it should be
>> fixed :)
>>     
>
> No, U-Boot doesn't have this problem.
>
> Best regards,
> Stefan
>   
Thanks for the confirmation! One less thing to worry about.

Cheers,
   Sean
