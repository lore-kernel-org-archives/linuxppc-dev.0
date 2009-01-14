Return-Path: <jacmet@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.191])
	by ozlabs.org (Postfix) with ESMTP id BD877DE079
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 01:47:16 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id e27so152073nfd.9
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 06:47:14 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] dts-bindings/fsl/dma.txt: fix IRQ number in mpc83xx dma
	example
References: <1231942453-17898-1-git-send-email-jacmet@sunsite.dk>
	<20090114142135.GA22862@oksana.dev.rtsoft.ru>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 14 Jan 2009 15:47:10 +0100
In-Reply-To: <20090114142135.GA22862@oksana.dev.rtsoft.ru> (Anton Vorontsov's
	message of "Wed\, 14 Jan 2009 17\:21\:35 +0300")
Message-ID: <87sknmaqs1.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Anton" == Anton Vorontsov <avorontsov@ru.mvista.com> writes:

Hi,

 >> interrupt-parent = <&ipic>;
 >> -		interrupts = <47 8>;
 >> +		interrupts = <71 8>;

 Anton> 0x47 = 71 ;-) The example is in the dts-v0 format, all the numbers
 Anton> are hexadecimal.

Ahh ;)

-- 
Bye, Peter Korsgaard
