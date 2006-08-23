Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 093C167BC3
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 09:59:47 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7NNxf0s014486
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 19:59:41 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7NNxeJa334888
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 17:59:40 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7NNxenO016454
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 17:59:40 -0600
Date: Wed, 23 Aug 2006 18:59:40 -0500
To: dtutty@porchlight.ca
Subject: Re: boot problems on pseries
Message-ID: <20060823235939.GI4401@austin.ibm.com>
References: <20060820170055.GA8958@hooton> <20060821145624.GA30464@aepfle.de>
	<20060822165023.GA4807@hooton>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060822165023.GA4807@hooton>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 22, 2006 at 12:50:26PM -0400, dtutty@porchlight.ca wrote:
> Boot failures:
> 
> 	1.	CD not recognized as bootable, so use OF manually.
> 	2.	OF manually will boot yaboot.
> 	3.	yaboot doesn't find its config in the /etc directory
> 		of the cd, nor in the / directory of the CD with the
> 		yaboot executable.
> 	4.	when manually from yaboot attempt to boot a kernel
> 		image, get either:
> 			a)	CLAIMED	FAILED	

Olaf's suggestion to use netboot is a good one.

Have you tried googling "yaboot claim fail"?

I see suggetions to run yabootconfig, which normally
writes stuff to a special boot partition at /dev/sda1  
No clue how to do this for a CD.

The BSD faq has a long discussion

http://www.netbsd.org/Ports/macppc/faq.html#ofw-claim-failed

which seems to indicate that some load or offset is being
incorrectly specified.

There seem to be plenty of other discussions as well

--linas
