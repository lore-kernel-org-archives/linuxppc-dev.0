Return-Path: <walt.wimer@timesys.com>
Received: from postfix.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id AA3FC679E9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 May 2006 06:19:32 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by postfix.timesys.com (Postfix) with ESMTP id 6A3178069798
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 May 2006 16:19:33 -0400 (EDT)
Received: from postfix.timesys.com ([127.0.0.1])
	by localhost (postfix.timesys.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 07139-01 for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 May 2006 16:19:31 -0400 (EDT)
Received: from exchange.timesys.com (exchange.timesys.com [192.168.2.250])
	by postfix.timesys.com (Postfix) with ESMTP id BA65E8069796
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 May 2006 16:19:31 -0400 (EDT)
Subject: Re: IMAP_ADDR on PPC 8xx
From: "Walter L. Wimer III" <walt.wimer@timesys.com>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <6CE25E1C-0F7A-4644-926E-746C17A7A851@embeddedalley.com>
References: <4D8794260B62C940BBA7150CC5EB3BD43D23CA@bosmail.BOS.int.mrv.com>
	<1147204345.3139.11.camel@excalibur.timesys.com>
	<3A4FA660-AD13-4E2B-846B-B9ACD901444F@embeddedalley.com>
	<1147274635.23931.17.camel@excalibur.timesys.com>
	<1147279763.23931.32.camel@excalibur.timesys.com>
	<6CE25E1C-0F7A-4644-926E-746C17A7A851@embeddedalley.com>
Content-Type: text/plain
Date: Wed, 10 May 2006 16:19:22 -0400
Message-Id: <1147292362.23931.45.camel@excalibur.timesys.com>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2006-05-10 at 13:45 -0400, Dan Malek wrote:
> > This may be fine for non-Linux purposes, but it looks like we need
> > to spread some gospel to Freescale regarding the correct IMMR
> > address for U-Boot / Linux....
> 
> I think you better be pointing fingers at the clueless person that
> provided the software you have, as it didn't come from Freescale nor
> any of the public U-Boot sources.


My sincerest apologies to Freescale.  Upon further research, it appears
that it was another TimeSys engineer (who has since moved on to another
job) who built and installed U-Boot on our MPC885ADS board.  Strangely,
it appears that he started with the community U-Boot 1.1.3 and then
added a patch to change the IMMR value (plus a few other things).  I'm
not sure why.  He's a very bright guy, so I'm very puzzled....

Anyway, mystery solved.

Again, my sincerest apologies to Freescale.

I built the community U-Boot 1.1.4 and flashed it onto our board.  Linux
2.6.16.11 now boots much farther than before (I'm now getting printk()
output).  The kernel is hitting a new problem now, but I suspect it may
be related to the TLB code that Marcello has discussed recently.  I'm
going to go look at that patch next.  :-)


> Thanks.
> 
>         -- Dan


Thanks again to everyone!!!

Walt Wimer
TimeSys Corporation
