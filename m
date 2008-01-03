Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AECFEDDE35
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Jan 2008 21:34:53 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JANPU-0004Rd-PI
	for linuxppc-embedded@ozlabs.org; Thu, 03 Jan 2008 02:34:48 -0800
Message-ID: <14594687.post@talk.nabble.com>
Date: Thu, 3 Jan 2008 02:34:48 -0800 (PST)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: (no subject)
In-Reply-To: <22A704B880BBD94A9E52BD6FA90C63D702F4483A@BUDMLVEM08.e2k.ad.ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <22A704B880BBD94A9E52BD6FA90C63D702F4483A@BUDMLVEM08.e2k.ad.ge.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I can tell you from Software point of view ....There should be One Time
Master and others as time slave data would be transmitted via Ethernet and
PPS through OFC ...Ntp should be runing ...I guess this is a way in which we
could Sync all the other boards ....

----Misbah <><

Awad, Sinan (GE Healthcare) wrote:
> 
> Hello all
>  
> I'm trying to understand if we need to move from MPC8347 to MPC8360 in
> our boards.
> One of the features that most attracts, is the eTSEC which includes
> support for IEEE 1588 PTP time synchronization.
> I need to synchronize the clock of 3 boards via ethernet, I need a time
> resolution of under 1ms.
>  
> Has anyone had the pleasure of playing around with time synchronization
> ?
> Do I really need the hardware capabilities for this type of time
> resolution ? or can I implement it in software ?
>  
> Thanks in advance.
> Sinan
>  
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 

-- 
View this message in context: http://www.nabble.com/%28no-subject%29-tp14593723p14594687.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
