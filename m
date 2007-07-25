Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E6820DDE3C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Jul 2007 16:26:36 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IDaKP-0006IR-Fi
	for linuxppc-embedded@ozlabs.org; Tue, 24 Jul 2007 23:26:33 -0700
Message-ID: <11777050.post@talk.nabble.com>
Date: Tue, 24 Jul 2007 23:26:33 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Circular queue
In-Reply-To: <46A5B5BA.2080707@dlasys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <46A5B5BA.2080707@dlasys.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


hi ....

Yes ofcourse there is a data structure for circular buffer implementation in
the driver but for the version 2.6.10 and onwards. Just see the
documentation on header file <linux/kfifo.h> I myself never tried with this
,where in i had implimented a circular buffer in the kernel and you need to
take care with the read index and write index. I suggest you to built your
own circular buffer insted on relaying on the standered because as far as i
know you should not relay on something new and untested . If you feel any
problem in the implementation i can help you in that. 

regard 
Misbah


David H. Lynch Jr.-2 wrote:
> 
>     Is there a standard linux datastructure and routines to manage
> circular queues ?
> 
>     I have a device that is not fundimentally different from a serial
> character device
>     except it is faster and the fundimental data type is 36 bits large.
> 
>     I have coded my own routines to setup and maintain a simple circular
> queue,
>     but I was hoping that there might be something more standard that
> already exists.
> 
>     Anyone know of anything ?
>    
> 
>    
> 
> 
> 
> 
> 
> -- 
> Dave Lynch 					  	    DLA Systems
> Software Development:  				         Embedded Linux
> 717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
> fax: 1.253.369.9244 			           Cell: 1.717.587.7774
> Over 25 years' experience in platforms, languages, and technologies too
> numerous to list.
> 
> "Any intelligent fool can make things bigger and more complex... It takes
> a touch of genius - and a lot of courage to move in the opposite
> direction."
> Albert Einstein
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/Circular-queue-tf4134423.html#a11777050
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
