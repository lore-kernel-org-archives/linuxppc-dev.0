Return-Path: <dtutty@porchlight.ca>
Received: from tor-pinab.porchlight.ca (tor-pinab.porchlight.ca
	[209.171.52.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B4D6867C0D
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 05:46:57 +1000 (EST)
Received: from keep.hooton (tor-ppp-209.29.44.168.porchlight.ca
	[209.29.44.168]) (authenticated bits=0)
	by tor-pinab.porchlight.ca (8.13.1/8.13.1) with ESMTP id k7MJknLw027012
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 15:46:50 -0400
Received: from dtutty by keep.hooton with local (Exim 4.50) id 1GFZSP-0001mq-CE
	for linuxppc-dev@ozlabs.org; Tue, 22 Aug 2006 12:50:29 -0400
Date: Tue, 22 Aug 2006 12:50:26 -0400
From: dtutty@porchlight.ca
To: linuxppc-dev@ozlabs.org
Subject: Re: boot problems on pseries
Message-ID: <20060822165023.GA4807@hooton>
References: <20060820170055.GA8958@hooton> <20060821145624.GA30464@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060821145624.GA30464@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 21, 2006 at 04:56:24PM +0200, Olaf Hering wrote:
> On Sun, Aug 20, 2006 at 01:00:56PM -0400, dtutty@porchlight.ca wrote:
> 
> > Does anyone have a link to a boot/root floppy set that will work?
> 
> openSuSE will likely work, but do you have any details of the boot
> failures and what exactly you have tried so far?
> 
> 
Boot failures:

	1.	CD not recognized as bootable, so use OF manually.
	2.	OF manually will boot yaboot.
	3.	yaboot doesn't find its config in the /etc directory
		of the cd, nor in the / directory of the CD with the
		yaboot executable.
	4.	when manually from yaboot attempt to boot a kernel
		image, get either:
			a)	CLAIMED	FAILED	
			b)	incorrect ELF format
				(something like that, I wasn't there
				when the tech got that one)
			c)	not a valid kernel image

At no point do I get any indication that the linux kernel has had a
chance to try booting; it doesn't get that far.


Thanks,

I'll look at SuSE and see if there's a free-download of a boot floppy.

Doug.
