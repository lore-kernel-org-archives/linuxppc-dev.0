Return-Path: <bounces@nabble.com>
Received: from talk.nabble.com (www.nabble.com [72.21.53.35])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 91E80DDE2E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Jan 2007 09:39:53 +1100 (EST)
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50) id 1H7JRd-0006ky-9v
	for linuxppc-embedded@ozlabs.org; Wed, 17 Jan 2007 14:39:49 -0800
Message-ID: <8421165.post@talk.nabble.com>
Date: Wed, 17 Jan 2007 14:39:49 -0800 (PST)
From: RichardL <richard.lowry@weatherford.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Using Linux on an FX60 board
In-Reply-To: <456C1611.3010605@computing.dundee.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <456AF9A5.70301@computing.dundee.ac.uk>
	<456C1611.3010605@computing.dundee.ac.uk>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello all!

Has anyone gotten to the point where they are trying to load LENOX on their
application board which is using an FX60. The FX60 has two Power PCs and we
are having trouble loading LENOX from the sysace to our ddr. Has anyone
experienced difficulties due to the dual ppcs?

Richard Lowry
Weathorford International
Ft Worth, Texas



Peter Mendham wrote:
> 
> Sharon Feldman wrote:
>> > [snip]
>> > I have a few questions, I was wondering if someone could help me out:
>> > [snip]
>> > 3) I will eventually be wanting tri-mode ethernet support, ideally
>> under 
>> > a 2.6 kernel.  I've been trying to follow the discussions on this 
>> > mailing list with respect to the support for the tri-mode MAC and 
>> > scatter gather/DMA support.  Can anyone summarise what sort of stage 
>> > this is at? Is auto-negotiation supported? Once I get past the hurdles
>> I 
>> > have at the moment my next step is to attempt incorporating the
>> tri-mode 
>> > IP and getting it working under Linux.  If there's anything I can do to 
>> > help the effort at that point I'd be glad to put in some time.
>>
>> The Adaptor Files Nee To Be Updated To ML405, To Support Tri-Mode
>> Auto-Negotiation.
>> The Current Driver Will Work Fine For 1GB, But That's All.
>>   
> Thanks for you reply, can you tell me where to look to find out more 
> about this?
> 
> -- Peter
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/Using-Linux-on-ML405%3A-Some-basic-questions-tf2712209.html#a8421165
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
