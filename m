Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CBD8CDDE04
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Sep 2007 18:25:30 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Ia5jT-00037o-Fw
	for linuxppc-embedded@ozlabs.org; Tue, 25 Sep 2007 01:25:27 -0700
Message-ID: <12875133.post@talk.nabble.com>
Date: Tue, 25 Sep 2007 01:25:27 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Linux doesn not boot from u-boot on ML403
In-Reply-To: <fa686aa40709230832m1d4a083ao2e43b57cc39e088@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <Pine.LNX.4.44.0709231519510.25165-100000@slslc02.psi.ch>
	<fa686aa40709230832m1d4a083ao2e43b57cc39e088@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Grant,

   Thank you very much for your response. actually I was wrong when saying:

> My observation is that the linux 2.6.23 rc-2 is not that stable as 2.6.21.
> In most cases It boots successfully (ie. zImage.elf) but occasionally it
> fails during booting. It has never occurred with 2.6.21 which I also
> copied from your side.

Both version of linux 2.6.21 and 2.6.23 run very well and always boot
properly.
To deal with u-boot and linux kernel I use jtag and load the software
straight to RAM.

I have difficulties to boot uImage (kernel v2.6.23) from u-boot 1.2.0. 
uImage boots sometimes from u-boot but zImage.elf boots always (when loaded
to RAM via jtag). 

It seems to be that I have the general problem with u-boot which I have
described on u-boot users forum:
http://www.nabble.com/u-boot-init-problem-on-ml403-%28virtex-4%29-board-tf4514050.html

Best Regards

Mirek




-- 
View this message in context: http://www.nabble.com/Re%3A-Linux-doesn-not-boot-from-u-boot-on-ML403-tf4504418.html#a12875133
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
