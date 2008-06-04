Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 92471DDEE9
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Jun 2008 20:47:59 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1K3qX6-0003DT-F6
	for linuxppc-embedded@ozlabs.org; Wed, 04 Jun 2008 03:47:56 -0700
Message-ID: <17643915.post@talk.nabble.com>
Date: Wed, 4 Jun 2008 03:47:56 -0700 (PDT)
From: gforgcc <narendra.ka@lntemsys.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Help on MPC82XX USB Host controller Development using m82xx-hcd.
In-Reply-To: <200806041229.32995.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <16304553.post@talk.nabble.com>
	<200803270956.12203.laurentp@cse-semaphore.com>
	<17643409.post@talk.nabble.com>
	<200806041229.32995.laurentp@cse-semaphore.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Laurent Pinchart-4 wrote:
> 
> 
> The good news is that Anton Vorontsov wrote and posted a FHCI driver for 
> QE-based parts on the linux-ppc mailing list (search the archive for
> "[PATCH] 
> Freescale QUICC Engine USB Host Controller"). The driver can be easily 
> modified to work with CPM2-based parts.
> 
> The bad news is that, from my experience with the CPM2, the controller is 
> almost unusable. It eats around 40% CPU time on my MPC8248 system, and 
> requires software help to generate SOF tokens, which results in bad SOF 
> tokens being sent on the bus. Most USB disks don't seem to care, but all
> the 
> USB Bluetooth host controllers I've tested crashed.
> 
> We will be looking for an external USB host controller (or even another
> CPU) 
> for the next revision of the design.
> 
> 
oh.. woww.. great info...  :) :) thanks a million.. 
Right now I am just trying to get a USB -WiFi adapter working with EP8248
board.  Did you have a go at any USB WiFi devices?

Yes hogging processor for 40% of time is a big issue...I guess at this
moment I don't have any other options like respining or using 83xx
processors so I would like to give a try with this once.  Do you have a
patch for getting the CPM2 posted any where? If not can you send me the
patch.

Thanks and Regards 
Naren.



-- 
View this message in context: http://www.nabble.com/Help-on-MPC82XX-USB-Host-controller-Development-using-m82xx-hcd.-tp16304553p17643915.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
