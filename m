Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 25C76DDE1A
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Jun 2008 20:13:04 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1K3pzG-0001ux-Uj
	for linuxppc-embedded@ozlabs.org; Wed, 04 Jun 2008 03:12:58 -0700
Message-ID: <17643409.post@talk.nabble.com>
Date: Wed, 4 Jun 2008 03:12:58 -0700 (PDT)
From: gforgcc <narendra.ka@lntemsys.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Help on MPC82XX USB Host controller Development using m82xx-hcd.
In-Reply-To: <200803270956.12203.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <16304553.post@talk.nabble.com>
	<200803270956.12203.laurentp@cse-semaphore.com>
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
> The cpm2usb project isn't maintained. If possible you should upgrade to a
> more 
> recent kernel and switch to the powerpc architecture where a new USB
> driver 
> called fhci is available.
> 
> The MPC872ADS is supported in recent kernels so switching shouldn't be too 
> difficult.
> 
> 

Hi Laurent,
i have some basic queries, i have some knowledge on what is UHCI or OHCI,
but can you please brief me what is FHCI and some info regarding this ?
googling on this dint help me much.. :(
we are using powerpc architecture with latest kernel 2.6.25.. and trying to
implement the USB host controller driver and have similar problems.. 

Thanks and Regards,
Naren.
-- 
View this message in context: http://www.nabble.com/Help-on-MPC82XX-USB-Host-controller-Development-using-m82xx-hcd.-tp16304553p17643409.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
