Return-Path: <jacmet@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by ozlabs.org (Postfix) with ESMTP id 168F2DDE09
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 May 2008 18:19:31 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id e27so1685780nfd.9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 May 2008 01:19:29 -0700 (PDT)
To: Jens Gehrlein <sew_s@tqs.de>
Subject: Re: smc911x: how to call the driver?
References: <4829BC19.5000909@tqs.de> <87hcd1749f.fsf@macbook.be.48ers.dk>
	<482A9CF0.7050600@tqs.de>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 14 May 2008 10:19:23 +0200
In-Reply-To: <482A9CF0.7050600@tqs.de> (Jens Gehrlein's message of "Wed\,
	14 May 2008 10\:04\:00 +0200")
Message-ID: <87iqxh5md0.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-embedded Mailinglist <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "Jens" == Jens Gehrlein <sew_s@tqs.de> writes:

Hi,

 Jens> on our board a SMSC LAN9215i is connected to an i.MX31 ARM
 Jens> processor. My hope is to get the smc911x driver run on this chip. The
 Jens> LAN921x data sheets say that existing 911x drivers should work.
 >> 
 >> Why are you asking this in a powerpc list?

 Jens> Uuh, sorry. In the haste I just read "embedded". Actually, my question
 Jens> isn't processor related. Rather it's (network) device driver related.
 Jens> Could you recommend a mailing list for this?

netdev@vger.kernel.org (see http://vger.kernel.org/vger-lists.html).

-- 
Bye, Peter Korsgaard
